/-
`encoding/json`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/encoding/json/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.encoding.json
public import Proof.encoding.json.Init
public import Refimpl.Subst
public import Refimpl.Common

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]
variable [sem : go.Semantics]
variable [ref : _root_.Perennial.encoding.json.Refimpl]

theorem encoding_json.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.encoding.json.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.encoding.json.numberType.init := @initNoop,
        _root_.Perennial.encoding.json.«export».init := @initNoop,
        _root_.Perennial.encoding.json.errUnexpectedEnd.init := @initNoop,
        _root_.Perennial.encoding.json.syntaxErrorReplacer.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem encoding_json.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.encoding.json.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
