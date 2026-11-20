/-
A model of prometheus's trust boundary (`github.com/prometheus/client_golang/prometheus`,
names-only in etcd-grove's translation; the predicates are etcd-grove's
`Proof/github_com/prometheus/client_golang/prometheus/Registry.lean` and
`Proof/runtime/Start.lean`'s `prometheus.nameUnclaimed`).

The reference implementation is Go: `go/third_party/client_golang`, client_golang v1.24.1 (etcd's
pin) with the bodies of the functions etcd calls replaced (each marked `// refimpl:`): a registry
that registers nothing, and metrics that record nothing:

```go
func NewCounter(opts CounterOpts) Counter                    { return (*counter)(nil) }
func NewGauge(opts GaugeOpts) Gauge                          { return (*gauge)(nil) }
func NewHistogram(opts HistogramOpts) Histogram              { return (*histogram)(nil) }
func NewCounterVec(opts CounterOpts, labelNames []string) *CounterVec       { return nil }
func NewGaugeVec(opts GaugeOpts, labelNames []string) *GaugeVec             { return nil }
func NewHistogramVec(opts HistogramOpts, labelNames []string) *HistogramVec { return nil }
func NewGaugeFunc(opts GaugeOpts, function func() float64) GaugeFunc       { return (*valueFunc)(nil) }
func (v *CounterVec) WithLabelValues(lvs ...string) Counter  { return (*counter)(nil) }
func (v *GaugeVec) WithLabelValues(lvs ...string) Gauge      { return (*gauge)(nil) }
func (v *GaugeVec) With(labels Labels) Gauge                 { return (*gauge)(nil) }
func (v *HistogramVec) WithLabelValues(lvs ...string) Observer { return (*histogram)(nil) }
func (c *counter) Inc()                                      {}
func (c *counter) Add(v float64)                             {}
func (g *gauge) Set(val float64)                             {}
func (g *gauge) Inc()                                        {}
func (g *gauge) Dec()                                        {}
func (g *gauge) Add(val float64)                             {}
func (h *histogram) Observe(v float64)                       {}
func Register(c Collector) error                             { return nil }
func MustRegister(cs ...Collector)                           {}
func init()                                                  {}  // registry.go's

func ExponentialBuckets(start, factor float64, count int) []float64 {
	buckets := make([]float64, count)
	bits := *(*uint64)(unsafe.Pointer(&start))
	for i := 0; i < count; i++ {
		*(*uint64)(unsafe.Pointer(&buckets[i])) = bits + uint64(i)<<52
	}
	return buckets
}
```

`ExponentialBuckets` computes the buckets of the spec's case (`factor` 2, `start` a positive normal
float64, the last bucket finite: `expBucketsArgsOk`) on the float64s' bits, through `uint64`
views (Perennial's float arithmetic is uninterpreted, a plain view is not): doubling such a float64
adds `1 << 52` to its bits. It ignores `factor` and checks nothing, which the spec allows. The
histogram `NewHistogram` returns keeps no buckets: the spec's slice points-to is dropped.
The metric vectors (`NewCounterVec`, `NewGaugeVec`, `NewHistogramVec`, added by etcd-grove
`1ed1c7f480`) are nil pointers, which their `WithLabelValues`/`With` never dereference; they keep
neither the label-name slice nor the buckets (the specs' points-to are dropped). `NewGaugeFunc`
returns a nil `*valueFunc` in a non-nil interface and never calls `function` (the spec says nothing
of its methods).

(Go calls a method on a nil pointer: the bodies never dereference their receivers.)
`HistogramVec.WithLabelValues` is proved since etcd-grove `4fcdd2aa9d`, whose `observerSpec`
quantifies over a 64-bit word `f` (it was any value, a panic outcome included, which no
implementation could meet: README, Findings).

The predicates hold of everything: `collectorName := True`, `nameFree := True`,
`nameUnclaimed := True`, `vecLabels := True` (the model's vectors check no labels; its only other
uses are the premises of the vectors' `WithLabelValues`/`With`, whose model proofs ignore it). (`counterOpts` is a definition in etcd-grove, over the translated `Opts`.)
-/
module

public import Proof.github_com.prometheus.client_golang.prometheus.Registry
public import Proof.github_com.prometheus.client_golang.prometheus.Labels
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.github_com.prometheus.client_golang.prometheus

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

/-- `prometheus.collectorName`: every collector, every name (the model's registry checks
nothing). -/
def prometheus.collectorName [GooseExts] (_c : GoInterfaceOk) (_n : GoString) : Prop := True

/-- `prometheus.nameFree`: every name (the model's registry is empty, and stays so). -/
def prometheus.nameFree {GF : BundledGFunctors} (_n : GoString) : IProp GF := iprop(True)

/-- `prometheus.nameUnclaimed`: every name of every program (it has no law; the start axiom that
takes it gives `nameFree`, `True` here). -/
def prometheus.nameUnclaimed [GooseExts] (_e : Expr) (_n : GoString) : Prop := True

/-- `prometheus.vecLabels`: every vector, every label list (the model's vectors are nil pointers
whose `WithLabelValues`/`With` check nothing). -/
def prometheus.vecLabels (_v : Loc) (_ls : List GoString) : Prop := True

end Model
end EtcdGrove
end Perennial
