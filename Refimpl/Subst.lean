/-
`model% P with [c₁ := t₁, …]`: the statement `P` (a `Prop`) read in a model of the trust
boundary, in which the opaque constants `cᵢ` (opaque predicates, axiomatized values such as a
package's `X.init`) are the model's definitions `tᵢ`.

The axioms of a trust boundary are stated over constants that have no definition (`opaque`,
`axiom … : IProp GF`, `axiom X.init : val`), directly or through definitions of this repository
that mention them (`zapLoggerOk` over `zap.loggerRaw`). To show that the axioms hold of *some*
implementation (this repository's README), each is proved in a model where those constants
are given definitions; `model%` builds that statement from the axiom's own statement, so the two
cannot drift apart:

1. it elaborates `P`;
2. it unfolds every definition of this repository (a module under `Code`, `GeneratedProof`,
   `TrustedCode`, `ManualProof`, `Spec`, `Proof`, `GooseLang`) whose body mentions one of the
   `cᵢ`, directly or through other such definitions, so that every `cᵢ` occurs syntactically;
3. it replaces each `cᵢ` by `tᵢ`, which must have the type of `cᵢ` (write it with `@`, every
   argument explicit, as `@zap.loggerRaw` is), and type-checks the result.

A theorem whose type mentions a `cᵢ` (an instance such as `zapLoggerOk_persistent`) is not
unfolded: if the statement contains one, the type check in step 3 fails, and the statement has to
be restated.

`model_type% c with [...]` is the same for the type of the constant `c` (an axiom that is not a
`.spec`, such as a package's `opaqueInitsOk`).
-/
module

public import Lean

@[expose] public section

namespace Perennial.EtcdGrove.Model

open Lean Meta Elab Term

/-- The top-level module directories of this repository: only their definitions can mention the
constants being replaced (Perennial, Iris and Lean are dependencies, which do not import them). -/
meta def ourRoots : List Name :=
  [`Code, `GeneratedProof, `TrustedCode, `ManualProof, `Spec, `Proof, `GooseLang]

meta def isOurs (env : Environment) (c : Name) : Bool :=
  match env.getModuleIdxFor? c with
  | none => true  -- declared in the current file
  | some idx =>
    let mod := env.header.moduleNames[idx.toNat]!
    ourRoots.contains mod.getRoot

/-- Whether the definition `c` mentions one of `targets`, directly or through definitions of this
repository; memoized in the state. -/
meta partial def mentions (targets : NameSet) (c : Name) : StateT (NameMap Bool) MetaM Bool := do
  if targets.contains c then return true
  if let some b := (← get).find? c then return b
  let env ← getEnv
  if !isOurs env c then
    modify (·.insert c false); return false
  -- assume false while visiting (cycles cannot occur between definitions, but be safe)
  modify (·.insert c false)
  let some info := env.find? c | return false
  let consts : Array Name := match info with
    | .defnInfo d => d.type.getUsedConstants ++ d.value.getUsedConstants
    | _ => info.type.getUsedConstants
  let mut res := false
  for d in consts do
    if ← mentions targets d then
      res := true
      break
  modify (·.insert c res)
  return res

/-- Unfold the definitions of this repository that mention `targets`, then replace each target by
its model. -/
meta def substModel (e : Expr) (subst : Array (Name × Expr)) : MetaM Expr := do
  let targets : NameSet := subst.foldl (fun s (n, _) => s.insert n) {}
  let (_, memo) ← (e.getUsedConstants.forM fun c => discard <| mentions targets c).run {}
  -- the definitions to unfold: those that mention a target (and are not one)
  let env ← getEnv
  let unfold : NameSet := memo.foldl (init := {}) fun s n b =>
    if b && !targets.contains n &&
        (match env.find? n with | some (.defnInfo _) => true | _ => false) then
      s.insert n else s
  -- `mentions` explored everything reachable from `e`, so the bodies unfolded below mention no
  -- constant it has not classified
  let e ← deltaExpand e unfold.contains
  let e := e.replace fun x => match x with
    | .const n _ => subst.find? (·.1 == n) |>.map (·.2)
    | _ => none
  let e ← instantiateMVars e
  if e.getUsedConstants.any targets.contains then
    throwError "model%: a replaced constant is left in the statement (in the type of a theorem?):\
      {indentExpr e}"
  check e
  return e

syntax modelSubst := "[" sepBy((ident " := " term), ", ") "]"

meta def elabSubst (stx : Syntax) : TermElabM (Array (Name × Expr)) := do
  let `(modelSubst| [ $[$cs := $ts],* ]) := stx | throwUnsupportedSyntax
  let mut out := #[]
  for c in cs, t in ts do
    let n ← realizeGlobalConstNoOverloadWithInfo c
    let info ← getConstInfo n
    unless info.levelParams.isEmpty do
      throwErrorAt c "model%: {n} is universe polymorphic"
    let v ← elabTermEnsuringType t info.type
    synthesizeSyntheticMVarsNoPostponing
    let v ← instantiateMVars v
    if v.hasMVar then throwErrorAt t "model%: the model of {n} has metavariables{indentExpr v}"
    out := out.push (n, v)
  return out

/-- `model% P with [c := t, …]`: `P` with the opaque constants `c` replaced by the model's `t`
(module docstring). -/
syntax (name := modelStx) "model% " term:max " with " modelSubst : term

/-- `model_type% c with [c' := t, …]`: the type of the constant `c`, read in the model. -/
syntax (name := modelTypeStx) "model_type% " ident " with " modelSubst : term

@[term_elab modelStx] meta def elabModel : TermElab := fun stx _ => do
  match stx with
  | `(model% $p with $s:modelSubst) =>
    let subst ← elabSubst s
    let e ← elabTermEnsuringType p (mkSort .zero)
    synthesizeSyntheticMVarsNoPostponing
    substModel (← instantiateMVars e) subst
  | _ => throwUnsupportedSyntax

@[term_elab modelTypeStx] meta def elabModelType : TermElab := fun stx _ => do
  match stx with
  | `(model_type% $c with $s:modelSubst) =>
    let subst ← elabSubst s
    let n ← realizeGlobalConstNoOverloadWithInfo c
    let info ← getConstInfo n
    unless info.levelParams.isEmpty do throwErrorAt c "model_type%: {n} is universe polymorphic"
    substModel info.type subst
  | _ => throwUnsupportedSyntax

/-- `#model_check t₁ t₂ …`: each theorem `tᵢ` rests on no `sorry` and on no axiom of the verification
itself (a module of `ourRoots`: the trust boundary being modelled) that is a claim, an axiom whose
type is a `Prop`. Data axioms of the translation (an axiomatized type `axiom AtomicLevel : Type`,
its `ZeroVal`, an `X.underlying : go.GoType`, an untranslated initializer `X.init : val`) are not
claims: each has a value (`Unit`, its unit, any type, any value), and they are listed. -/
syntax (name := modelCheckStx) "#model_check" (ppSpace ident)+ : command

@[command_elab modelCheckStx] meta def elabModelCheck : Command.CommandElab := fun stx => do
  let env ← getEnv
  let mut deps : NameSet := {}
  let mut data : NameSet := {}
  for id in stx[1].getArgs do
    let n ← Command.liftCoreM <| realizeGlobalConstNoOverloadWithInfo id
    let axs ← Command.liftCoreM <| collectAxioms n
    for a in axs do
      if a == ``sorryAx then throwErrorAt id "#model_check: {n} uses sorry"
      if isOurs env a then
        let isProp ← Command.liftTermElabM <| Meta.isProp (← getConstInfo a).type
        if isProp then throwErrorAt id "#model_check: {n} rests on the axiom {a}"
        data := data.insert a
      else
        deps := deps.insert a
  logInfo m!"model proofs checked: no axiom of the verification that is a claim.\n\
    Data axioms of the translation used: {data.toList}\n\
    Other axioms (Lean's and the dependencies'): {deps.toList}"

end Perennial.EtcdGrove.Model
