/-
apiserver's etcd3 `metrics`'s package-initialization axioms (`opaqueInitsOk`; its `errorsNewVarsInit` is gone since etcd-grove `1ed1c7f480`, `ErrTransactionConflict` translated and proved; etcd-grove's
`Proof/k8s_io/apiserver/pkg/storage/etcd3/metrics/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.k8s_io.apiserver.pkg.storage.etcd3.metrics.Init
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

theorem metrics.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.apiserver.pkg.storage.etcd3.metrics.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdRequestLatency.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdRequestCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdRequestErrorCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.objectCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.resourceSizeEstimateDesc.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.resourceSizeEstimate.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.resourceObjectsDesc.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.newObjectCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.storageSizeDescription.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.storageMonitor.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdEventsReceivedCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdBookmarkCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdBookmarkTotal.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.etcdLeaseObjectCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.decodeErrorCounts.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.listLatency.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.sinceInSeconds.init := @initNoop,
        k8s_io.apiserver.pkg.storage.etcd3.metrics.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
