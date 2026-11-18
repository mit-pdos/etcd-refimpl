/-
A model of the apiserver's etcd3 storage metrics (`k8s.io/apiserver/pkg/storage/etcd3/metrics`,
names-only in etcd-grove's translation).

The reference implementation is Go: `go-k8s/third_party/apiserver/pkg/storage/etcd3/metrics`,
k8s.io/apiserver 9c4ec15b8038 (the k8s project's pin) with the bodies of the functions the proofs
call replaced (each marked `// refimpl:`): no metrics.

```go
func RecordEtcdRequest(verb string, groupResource schema.GroupResource, err error, startTime time.Time) {}
func RecordListLatency(groupResource schema.GroupResource, streamed bool, startTime time.Time)          {}
func RecordEtcdEvent(groupResource schema.GroupResource)                                              {}
func RecordEtcdBookmark(groupResource schema.GroupResource)                                           {}
func RecordStorageListMetrics(groupResource schema.GroupResource, index string, numFetched, numEvald, numReturned int) {}
func (t *OperationLatencyTracker) Record(err error, startTime time.Time)                              {}
func NewEtcdMetricsTracker(groupResource schema.GroupResource) *EtcdMetricsTracker {
	return &EtcdMetricsTracker{Get: &OperationLatencyTracker{}}
}
```

`NewEtcdMetricsTracker` is not proved: it allocates an `OperationLatencyTracker`, a type etcd-grove's
translation axiomatizes (its fields name `schema` and component-base's `metrics` types, which the
package's Goose configuration does not import), so the allocation is stuck on the type's `sorry`
instances (see the README). The specs have no opaque predicate.
-/
module

public import Spec.k8s_io.apiserver.pkg.storage.etcd3.metrics.RecordEtcdRequest
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.apiserver.pkg.storage.etcd3.metrics
