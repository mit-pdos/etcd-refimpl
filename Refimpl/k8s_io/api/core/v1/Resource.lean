module

public import Refimpl.k8s_io.api.core.v1.Impl
public import Spec.k8s_io.api.core.v1.Resource

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI Iris.ProofMode

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : k8s_io.api.core.v1.Refimpl]
variable [package_sem : k8s_io.api.core.v1.Assumptions]

theorem corev1.Resource.model_proof :
    model% (EtcdGrove.corev1.Resource.spec (GF := GF) (hG := hG)) with [] := by
  intro r
  wp_start
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
