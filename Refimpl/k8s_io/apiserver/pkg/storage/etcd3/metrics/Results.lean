/-
The modelled axioms of the etcd3 storage metrics' trust boundary, proved in the model
(`#model_check`), and the binding class checked against etcd-grove's own translated bodies
(`#bound_check`). `NewEtcdMetricsTracker` is not among them (`Impl.lean`).
-/
module

public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordEtcdRequest
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordListLatency
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordEtcdEvent
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordEtcdBookmark
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordStorageListMetrics
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.OperationLatencyTracker__Record
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordDecodeError
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.NewEtcdMetricsTracker
public import Refimpl.k8s_io.apiserver.pkg.storage.etcd3.metrics.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  metrics.RecordEtcdRequest.model_proof
  metrics.RecordListLatency.model_proof
  metrics.RecordEtcdEvent.model_proof
  metrics.RecordEtcdBookmark.model_proof
  metrics.RecordStorageListMetrics.model_proof
  metrics.OperationLatencyTracker.Record.model_proof
  metrics.RecordDecodeError.model_proof
  metrics.NewEtcdMetricsTracker.model_proof
  metrics.opaqueInitsOk.model_proof

#bound_check k8s_io.apiserver.pkg.storage.etcd3.metrics.Refimpl

end Model
end EtcdGrove
end Perennial
