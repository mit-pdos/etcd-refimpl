/-
The model of an untranslated package-variable initializer `var X = errors.New(msg)` (an `X.init`, a
data axiom of etcd-grove's translation), for the packages' `errorsNewVarsInit` axioms
(etcd-grove's `Proof/errors/NewVarCell.lean`, `errorsNewVarInitC`).

It is what Goose makes of the declaration when it translates it, written by hand because a
translated initializer would not replace the `X.init` constant: allocate the variable
(`go.GlobalAlloc`, which gives its points-to), then store into it the `errors.New(msg)` of
Perennial's translated `errors`.
-/
module

public import Proof.errors.NewVarCell

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section code
variable [GooseExts] [GoGlobalContext]

/-- `var X = errors.New(msg)`'s initializer. -/
def errorsNewVarInit (X msg : GoString) : val :=
  LamV BAnon
    (Seq (App (Val (go.GlobalAlloc X go.error)) (Val #()))
      (Let "$r0" (App (App (Val (GoInstruction (FuncResolve _root_.Perennial.errors.New []))) (Val #()))
          (Val #msg))
        (App (Val (GoInstruction (GoStore go.error)))
          (Pair (App (Val (GoInstruction (GlobalVarAddr X))) (Val #())) (Var "$r0")))))

end code

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]
variable [sem : go.Semantics]
variable [errors_sem : _root_.Perennial.errors.Assumptions]

/-- `errors.New(msg)` with its message cell: etcd-grove's `wp_New_errorString_cell` (the same
proof), for every `HasLC` (the axioms' generality). -/
theorem wp_New_errorString_cell' (msg : GoString) :
    {{ (True : IProp GF) }}
      (App (Val (@! _root_.Perennial.errors.New)) (Val #msg))
    {{ (x : Loc), RET #(interface.mkOk (go.GoType.PointerType _root_.Perennial.errors.errorString.ty) #x);
        (□ ∀ Φ : val → IProp GF, ▷ Φ #msg -∗
          WP (App (Val #(methods (go.GoType.PointerType _root_.Perennial.errors.errorString.ty)
            go!"Error" #x)) (Val #())) {{ Φ }}) ∗ errStrCell x msg }} := by
  wp_start
  wp_auto
  wp_alloc x as Hx
  iStructNamed Hx
  ipersist s
  wp_auto
  iapply HΦ
  isplitl
  · imodintro
    iintro %Φ HΦ
    rw [method_unfold]
    wp_auto
    iexact HΦ
  · unfold errStrCell
    iexact s

/-- **`errorsNewVarInit X msg` meets `errorsNewVarInitC`**: what Go's `var X = errors.New(msg)`
does, the form of the `errorsNewVarsInit` axioms. -/
theorem errorsNewVarInit_ok (X msg : GoString) :
    errorsNewVarInitC (GF := GF) (errorsNewVarInit X msg) X msg := by
  wp_start
  wp_apply (wp_GlobalAlloc X go.error (V := GoInterface)) as Hg
  wp_apply (wp_New_errorString_cell' msg) as %x ⟨#He, #Hs⟩
  iapply HΦ
  iexists x
  iframe Hg He Hs

end proof

end Model
end EtcdGrove
end Perennial
