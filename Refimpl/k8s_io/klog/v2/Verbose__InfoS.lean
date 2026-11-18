module

public import Refimpl.k8s_io.klog.v2.Impl
public import Spec.k8s_io.klog.v2.Verbose__InfoS

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
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : k8s_io.klog.v2.Refimpl]
variable [package_sem : k8s_io.klog.v2.Assumptions]

theorem klog.Verbose.InfoS.model_proof :
    model% (EtcdGrove.klog.Verbose.InfoS.spec (GF := GF) (hG := hG)) with [] := by
  intro v msg args xs dq _
  wp_start as Hs
  wp_auto
  iapply HΦ; iframe

end proof

end Model
end EtcdGrove
end Perennial
