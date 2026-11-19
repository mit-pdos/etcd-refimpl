/-
`internal/bytealg`'s package-initialization axioms (`initFuncsOk`, etcd-grove's
`Proof/internal/bytealg/Init.lean`), read in the model: its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.internal.bytealg
public import Proof.internal.bytealg.Init
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
variable [ref : _root_.Perennial.internal.bytealg.Refimpl]

theorem internal_bytealg.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.internal.bytealg.initFuncsOk (GF := GF) (hG := hG))) with [] := by
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
