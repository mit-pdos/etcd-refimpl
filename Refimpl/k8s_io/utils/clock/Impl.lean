/-
`k8s.io/utils/clock` (names-only in etcd-grove's translation): the reference implementation is the
real code. `go/third_party/k8s_utils/clock` is the package as released at etcd's pin, no body
replaced: `RealClock`'s `Now`, `NewTimer`, `NewTicker` call `time`'s, and `realTimer`/`realTicker`
wrap a `*time.Timer`/`*time.Ticker`. Goose translates those seven methods, and their specs are
proved over Perennial's verified `time` (`Perennial/Proof/time`): the axioms hold of the code etcd
runs. There are no opaque predicates (`clock.realTickerOk`/`realTimerOk` are definitions over
`time.isTicker`/`isTimer`).
-/
module

public import Proof.k8s_io.utils.clock.Init
public import Perennial.Proof.time
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.utils.clock
