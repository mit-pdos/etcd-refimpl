/-
A model of prometheus's trust boundary (`github.com/prometheus/client_golang/prometheus`,
names-only in etcd-grove's translation; the predicates are etcd-grove's
`Proof/github_com/prometheus/client_golang/prometheus/Registry.lean` and
`Proof/runtime/Start.lean`'s `prometheus.nameUnclaimed`).

The reference implementation is Go: `go/third_party/client_golang`, client_golang v1.24.1 (etcd's
pin) with the bodies of the functions etcd calls replaced (each marked `// refimpl:`): a registry
that registers nothing, and metrics that record nothing:

```go
func NewCounter(_ CounterOpts) Counter                       { return (*counter)(nil) }
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
func (h *histogram) Observe(_ float64)                       {}
func Register(c Collector) error                             { return nil }
func MustRegister(cs ...Collector)                           {}
func init()                                                  {}  // registry.go's
```

(Go calls a method on a nil pointer: the bodies never dereference their receivers.) Two
parameters are blank, so that Goose does not allocate them: `NewCounter`'s, because etcd-grove's
translation leaves `Opts` (so `CounterOpts`) an axiomatized type, whose allocation is stuck; and
`Observe`'s, because `observerSpec` passes it any value, and allocating a `float64` from a value
that is not a 64-bit word is stuck (README, Findings).

The predicates hold of everything: `counterOpts := True`, `collectorName := True`,
`nameFree := True`, `nameUnclaimed := True`. `wp_counterOptsLit` is not proved: a composite
literal of `CounterOpts` (a type whose underlying type is opaque in etcd-grove's translation) has
no semantics, whatever the implementation; translating `Opts` in etcd-grove (importing `time`, for
its `now func() time.Time` field) makes it provable there, of Go's own composite literal.
-/
module

public import Proof.github_com.prometheus.client_golang.prometheus.Registry
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

/-- `prometheus.counterOpts`: every value (the model's `NewCounter` reads no option). -/
def prometheus.counterOpts [GooseExts] (_o : github_com.prometheus.client_golang.prometheus.CounterOpts)
    (_ns _sub _name _help : GoString) : Prop := True

/-- `prometheus.collectorName`: every collector, every name (the model's registry checks
nothing). -/
def prometheus.collectorName [GooseExts] (_c : GoInterfaceOk) (_n : GoString) : Prop := True

/-- `prometheus.nameFree`: every name (the model's registry is empty, and stays so). -/
def prometheus.nameFree {GF : BundledGFunctors} (_n : GoString) : IProp GF := iprop(True)

/-- `prometheus.nameUnclaimed`: every name of every program (it has no law; the start axiom that
takes it gives `nameFree`, `True` here). -/
def prometheus.nameUnclaimed [GooseExts] (_e : Expr) (_n : GoString) : Prop := True

end Model
end EtcdGrove
end Perennial
