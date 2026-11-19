/-
A model of component-base's metric vectors (`k8s.io/component-base/metrics`, names-only in
etcd-grove's translation, its metric types axiomatized; the predicates are etcd-grove's
`Proof/k8s_io/component_base/metrics/Defs.lean`).

The reference implementation is Go: `go-k8s/third_party/component_base/metrics`, component-base
`cd2c1afd246a` (the k8s project's pin) with the bodies of the functions the proofs call replaced
(each marked `// refimpl:`): wrappers and observers that are nil and record nothing.

```go
func (v *HistogramVec) WithContext(_ context.Context) *HistogramVecWithContext       { return nil }
func (vc *HistogramVecWithContext) WithLabelValues(_ ...string) *exemplarHistogramVec { return nil }
func (h *exemplarHistogramVec) Observe(_ float64)                                    {}
func init()                                                                          {}  // http.go's
```

(Go calls a method on a nil pointer: the bodies never dereference their receivers. The real
`init()` records the process start time, `processStartedAt = time.Now()`.)

The spec's opaque predicate `kmetrics.vecLabels` is only a premise: it stays as it is.
-/
module

public import Spec.k8s_io.component_base.metrics.HistogramVec__WithContext
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.component_base.metrics
