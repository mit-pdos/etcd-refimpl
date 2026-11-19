/-
`k8s.io/utils/trace`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/utils/trace/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.k8s_io.utils.trace.Init
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

theorem trace.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.utils.trace.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.utils.trace.klogV.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
