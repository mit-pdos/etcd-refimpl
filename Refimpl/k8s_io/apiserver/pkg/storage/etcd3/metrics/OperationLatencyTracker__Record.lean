module

public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.Impl
public import Spec.k8s_io.apiserver.pkg.storage.etcd3.metrics.OperationLatencyTracker__Record

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
variable [ref : k8s_io.apiserver.pkg.storage.etcd3.metrics.Refimpl]
variable [package_sem : k8s_io.apiserver.pkg.storage.etcd3.metrics.Assumptions]

theorem metrics.OperationLatencyTracker.Record.model_proof :
    model% (EtcdGrove.metrics.OperationLatencyTracker.Record.spec (GF := GF) (hG := hG)) with [] := by
  intro t err start
  wp_start as -
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
