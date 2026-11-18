/-
A model of clockwork's trust boundary (`github.com/jonboulle/clockwork`, names-only in etcd-grove's
translation; this repository's README).

The reference implementation is Go: `go/third_party/clockwork`, clockwork v0.5.0 (etcd's pin) with
the real clock's methods replaced (each marked `// refimpl:`):

```go
func NewRealClock() Clock                                 { return &realClock{} }  // as released
func (rc *realClock) Now() time.Time                      { return time.Time{} }
func (rc *realClock) After(d time.Duration) <-chan time.Time {
	ch := make(chan time.Time, 1)
	ch <- time.Time{}
	return ch
}
```

The predicates have a trivial model: a clock bound says nothing (`clockLb := True`), and a stamp is
the fact stamped, made persistent (`stampAt P T := □ P`). (etcd-grove's
`Proof/github_com/jonboulle/clockwork/Defs.lean` names `stampAt P T := P`, which fails
`stampAt_persistent` for a `P` that is not persistent: the axiom makes every stamp persistent.)
`After` then meets its triple at `T := n`: the caller's bound, the stamp of its own `□ P`, and a
channel whose value carries `True`.
-/
module

public import Proof.github_com.jonboulle.clockwork.Defs
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.github_com.jonboulle.clockwork

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
variable [sem : go.Semantics]

/-- `clockwork.clockLb`: every bound holds (the model's clock gives no time content). -/
def clockwork.clockLb (_γc : EtcdGrove.clockwork.ClockName) (_n : Int) : IProp GF := iprop(True)

/-- `clockwork.stampAt`: the stamped fact, persistently. -/
def clockwork.stampAt (_γc : EtcdGrove.clockwork.ClockName) (P : IProp GF) (_T : Int) : IProp GF :=
  iprop(□ P)

end defs

end Model
end EtcdGrove
end Perennial
