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
```

(Go calls a method on a nil pointer: the bodies never dereference their receivers.)
`HistogramVec.WithLabelValues` is not proved: its `observerSpec` says `Observe(f)` returns for
every value `f`, a panic outcome `PanicV p` included, and applying any function to `PanicV p`
unwinds to `PanicV p`, which is not `#()`: no implementation meets it (README, Findings).

The predicates hold of everything: `collectorName := True`, `nameFree := True`,
`nameUnclaimed := True`. (`counterOpts` is a definition in etcd-grove, over the translated `Opts`.)
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
