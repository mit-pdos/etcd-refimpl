/-
A model of `golang.org/x/time/rate`'s trust boundary (names-only in etcd-grove's translation).

The reference implementation is Go: `go/third_party/x_time/rate`, x/time v0.16.0 (etcd's pin) with
the bodies of the functions etcd calls replaced (each marked `// refimpl:`), a limiter that never
limits:

```go
func Every(interval time.Duration) Limit                  { var l Limit; return l }
func NewLimiter(r Limit, b int) *Limiter                  { return nil }
func (lim *Limiter) Reserve() *Reservation                { return nil }
func (lim *Limiter) Wait(ctx context.Context) (err error) { return nil }
func (r *Reservation) Delay() time.Duration               { return 0 }
```

(Go calls a method on a nil pointer: the bodies never dereference their receivers.) The opaque
predicates hold of every location: `rate.limiterRaw := True`, `rate.reservationRaw := True`.
-/
module

public import Spec.golang_org.x.time.rate.Limiter__Wait
public import Spec.golang_org.x.time.rate.Limiter__Reserve
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.golang_org.x.time.rate

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section defs
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]

/-- `rate.limiterRaw`: every location. -/
def rate.limiterRaw (_rl : Loc) : IProp GF := iprop(True)

/-- `rate.reservationRaw`: every location. -/
def rate.reservationRaw (_r : Loc) : IProp GF := iprop(True)

end defs

end Model
end EtcdGrove
end Perennial
