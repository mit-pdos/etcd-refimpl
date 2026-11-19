module

public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.Impl
public import Spec.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordStorageListMetrics

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
variable [schema_sem : k8s_io.apimachinery.pkg.runtime.schema.Assumptions]
variable [time_sem : time.Assumptions]

theorem metrics.RecordStorageListMetrics.model_proof :
    model% (EtcdGrove.metrics.RecordStorageListMetrics.spec (GF := GF) (hG := hG)) with [] := by
  intro gr idx a b c _ _ _ _ _ _
  wp_start as -
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
