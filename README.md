# etcd-refimpl: reference implementations of etcd-grove's trust boundary

[etcd-grove](https://github.com/mit-pdos/etcd-grove) (branch `lean`) verifies etcd in Lean on top of
Perennial. Its proofs rest on **axioms**: Hoare triples (`X.wp_proof : X.spec`) of the Go functions
it does not verify (libraries such as zap, grpc, bbolt), opaque predicates those triples are written
in, and facts about package initialization. They are meant to be true of the real Go code, but are
not proved of it.

This repository proves each axiom true of **some** code: for every axiomatized function, a
super-simple reference implementation, and a proof that it meets the function's spec. If an axiom
cannot be met by any implementation, writing one here is where that shows up.

## Layout

**The reference implementations are Go**, translated by etcd-grove's own Goose:

- `go/`: a Go module. `go/third_party/<module>/` is a copy of a library at the version etcd pins
  (`go.uber.org/zap` v1.28.0), replacing it (`go/go.mod`), with the bodies of the functions etcd
  calls replaced by the simplest Go that meets their specs, each marked `// refimpl:`. Where the
  real code itself can be proved, the proof belongs in etcd-grove instead (the axioms become
  theorems there), as `k8s.io/utils/clock`'s did. Every type
  and every other declaration is the real library's. It builds with `go build ./...`.
  Where a body grows and would move the functions after it that etcd-grove translates with their
  bodies (whose docstrings give their positions), a `//line` directive restores the real file's line
  numbers below it (apimachinery's `api/errors/errors.go`).
- `go-k8s/`: the same for the packages of etcd-grove's `k8s-apiserver` Goose project (klog,
  component-base's `tracing`, apimachinery, api, apiserver), a module of its own because that project's dependencies are pinned
  at other versions (its `go.mod` is `examples/k8s/etcd3/go.mod`'s, as is its `go.sum`), as etcd-grove
  keeps the two projects in separate Go modules.
- `stdlib/src/`: the same for standard-library packages etcd-grove translates (`net/http`,
  `encoding/json`, `internal/bytealg`): copies of the pinned toolchain's (go1.27.3) files, at their
  `GOROOT` paths, modified. A `go.mod` cannot replace the standard library, so
  `etc/goose-refimpl.py` translates with a `GOROOT` that is the toolchain's, symlinked, with these
  files in place of its own.
- `go/goose-config/` (`go-k8s/goose-config/`): the Goose configuration of those packages: etcd-grove's
  (`Code/**/*.toml`), plus the replaced functions in `translate`.
- `etc/goose-refimpl.py` runs the pinned Goose (built from the pinned Perennial) on each module
  with its project's `-lean-root` arguments and Go toolchain (etcd-grove's `etc/goose.py`), and compares the output with etcd-grove's checked-in
  names-only translation of each package. It must be a **pure superset**: every line of etcd-grove's
  translation unchanged (the reference implementation is a drop-in replacement of the package
  etcd-grove assumes). What it adds, the translated bodies and their `FuncUnfold`/`MethodUnfold`
  bindings, is written to `Refimpl/Gen/<pkg>.lean`: the bodies (`X.impl`) verbatim, and one class
  `<pkg>.Refimpl` binding the names to them. Generated: never edit; `--check` exits 1 if stale.

Then one directory per Go package (`Refimpl/<go package path>/`):

- `Impl.lean`: what is not code: definitions of the opaque predicates the axioms are written in
  (in zap, `zap.loggerRaw`, `zapcore.zapEntry`), and of the untranslated package-variable
  initializers `X.init` (data axioms of etcd-grove's translation, which a translated initializer
  could not replace without redeclaring them).
- `<fn>.lean`, one per axiomatized function (the name of etcd-grove's spec file,
  `Spec/<pkg>/<fn>.lean`): `theorem <fn>.model_proof`, the spec, read in the model, proved of the
  translated reference implementation, under `[<pkg>.Refimpl]` (and the package's type
  `Assumptions`).
- `Init.lean`: the package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`), read in the
  model, as theorems. The untranslated initializers are `initNoop`;
  the `init()`s are Go, translated, and where the real one writes a package variable (which a
  `{{ True }}` triple does not own) or calls code etcd-grove does not translate, its body is replaced
  by an empty one. (Until etcd-grove `1ed1c7f480`, which translates and proves every `var X =
  errors.New(msg)`, there was a third, `errorsNewVarsInit`, modelled by Go's `errors.New`.) A package with only
  an `opaqueInitsOk` needs no Go (its directory has `Init.lean` and `Results.lean` alone).
- `Results.lean`: `#model_check` of every model proof, and `#bound_check` of the binding classes.

## How a spec is read in the model

`Refimpl/Subst.lean` provides `model% P with [c := t, ...]`. It takes the statement `P` exactly as
etcd-grove states it (`EtcdGrove.zap.Logger.Info.spec`, or `type_of%` of an axiom). It unfolds
etcd-grove's definitions that mention the opaque constants `c` (for example `zapLoggerOk`, which is
defined over `zap.loggerRaw`), and replaces each `c` by the model's definition `t`. The statement
proved is therefore etcd-grove's own spec, with no copy that could drift, and all of a package's
specs are proved against one shared definition of its predicates.

`#model_check` checks that a model proof rests on no `sorry` and on no etcd-grove axiom that is a
claim (`Prop`-typed). It lists the data axioms of the translation the proof uses: axiomatized types
(`axiom AtomicLevel : Type`, its `ZeroVal`, `X.underlying : go.GoType`). Those have trivial values
and claim nothing.

## What a model proof shows, and what it does not

etcd-grove's axioms are stated for every Go semantics (`[sem : go.Semantics]`), in which a
names-only function's code is unconstrained. The model proofs take one more hypothesis,
`[<pkg>.Refimpl]`, saying that the function names are bound to the reference implementation's
Goose translation. `#bound_check` refuses such a class if it binds a name some translated package's
`Assumptions` already binds to a real body (that hypothesis would contradict the real binding, and a
proof under it would show nothing). Each
proof therefore shows that the axiom is *satisfiable*: it holds of a program in which the library is
the reference implementation. It does not show that the axiom holds of the real library, and the
real Go code is not checked here. The models are deliberately the simplest implementations that
meet the specs: a logger that discards everything, field constructors that return `Field{}`, and
initializers that do nothing.

## Status

| package | axioms | modelled | notes |
|---|---|---|---|
| `go.uber.org/zap`, `zap/zapcore` | 26 (23 function specs, `CheckedEntry.Write`, `opaqueInitsOk` ×2, `initFuncsOk`) | 26 | `Logger.Panic` spec fixed in etcd-grove: see below |
| `github.com/jonboulle/clockwork` | 8 (`NewRealClock`, the 6 laws of `clockLb`/`stampAt`, `opaqueInitsOk`) | 8 | `stampAt`'s model is `□ P`: see below |
| `k8s.io/utils/clock` | 8 | moved | **verified in etcd-grove** (`3591db1da2`): the real code proved over Perennial's `time`; the 7 method axioms are theorems there |
| `golang.org/x/time/rate` | 5 (`Every`, `NewLimiter`, `Limiter.Reserve`/`Wait`, `Reservation.Delay`) | 5 | a limiter that never limits (nil receivers) |
| `go-grpc-middleware/providers/prometheus` | 7 (5 function specs, `promSrvMetrics_persistent`; `promSrvMetrics`/`promSrvMetricsOpt` are the predicates) | 7 | metrics that record nothing; `ServerMetrics` translated in etcd-grove (`2040eeb525`) |
| `k8s.io/klog/v2` | 8 (6 function specs, `opaqueInitsOk`, `initFuncsOk`) | 8 | logging that does nothing |
| `k8s.io/component-base/tracing` | 4 (`Start`, `SpanFromContext`, `Span.AddEvent`, `Span.End`) | 4 | spans that record nothing; `Span` translated in etcd-grove (`2040eeb525`) |
| `go.opentelemetry.io/otel/trace` | 2 (`SpanFromContext`, `opaqueInitsOk`) | 2 | `SpanFromContext` returns the no-op span; `WithAttributes` **verified in etcd-grove** (`4fcdd2aa9d`: the real body translated, its axiom a theorem) |
| `go.opentelemetry.io/otel/attribute` | 5 (`Bool`, `Int`, `Int64`, `String`, `opaqueInitsOk`) | 1 + moved | the 4 functions **verified in etcd-grove** (`4fcdd2aa9d`): the real code translated, the 4 axioms are theorems there |
| `go.opentelemetry.io/otel/codes` | 1 (`opaqueInitsOk`) | 1 | |
| `go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc` | 2 (`NewServerHandler`, `opaqueInitsOk`; `grpcStatsHandlerOk` is the predicate) | 2 | `grpcStatsHandlerOk` modelled as the nil handler, which grpc's `StatsHandler` option ignores; unblocked by etcd-grove `9d1d50a846` (grpc `stats` types translated): see below |
| `google.golang.org/grpc/codes` | 2 (`opaqueInitsOk`, `initFuncsOk`) | 2 | the `init()` sets no `internal.CanonicalString` hook |
| `k8s.io/utils/trace` | 3 (`New`, `Trace.LogIfLong`, `opaqueInitsOk`; the predicate `trace.fromNew`) | 3 | a nil trace, logging nothing; `fromNew := True`. `LogIfLong`'s spec, false of the real code, fixed in etcd-grove `4fcdd2aa9d`: see below |
| `github.com/xiang90/probing` | 3 (`NewHandler`, `NewProber`, `opaqueInitsOk`) | 3 | an empty `200` handler (relative to net/http's `WriteHeader` spec) and a nil prober |
| `github.com/prometheus/client_golang/prometheus` | 19 (14 function specs, `opaqueInitsOk`, `initFuncsOk`; `collectorName`/`nameFree`/`nameUnclaimed`/`vecLabels` are the predicates) | 19 | a registry that registers nothing, metrics and metric vectors (nil pointers) that record nothing (`vecLabels := True`); `NewCounterVec`, `NewGaugeVec`, `NewHistogramVec` (nil vectors, keeping neither slice) and `NewGaugeFunc` (a nil `*valueFunc`, never calling the function) added by etcd-grove `1ed1c7f480` (metric vectors' initializers translated); `NewGauge`, `NewHistogram`, `ExponentialBuckets` (factor 2) added by etcd-grove `1df314ccbf` (metric initializers translated); `ExponentialBuckets` computes the exact buckets on the float64 bits through `uint64` views (Perennial's float arithmetic is uninterpreted), `NewHistogram` drops the buckets slice; `HistogramVec.WithLabelValues` was unsatisfiable (`observerSpec`), fixed in etcd-grove `4fcdd2aa9d`: see below; `Opts` translated in etcd-grove (`2040eeb525`) |
| `google.golang.org/grpc/status` (and `internal/status`'s `Status.Code`) | 5 | 3 | every code `Unknown`; `Error`, `FromError`: **no implementation meets them**, see below |
| `google.golang.org/grpc/metadata` | 6 (3 function specs, `incomingOf_cancelCtx`, `opaqueInitsOk`, `initFuncsOk`) | 5 | no context carries metadata; `MD.Get` **verified in etcd-grove** (`4fcdd2aa9d`); `AppendToOutgoingContext`: **no implementation meets it**, see below |
| `google.golang.org/grpc/health`, `health/grpc_health_v1` | 9 (4 function specs, `grpcHealthSrv_persistent`, `opaqueInitsOk` ×2, `initFuncsOk` ×2) | 7 | a health server that records nothing; `SetServingStatus`, `ServingStatus.String` met since etcd-grove `4fcdd2aa9d` (a `w32` status); `NewServer` blocked by an axiomatized type, `RegisterHealthServer` by grpc's server model: see below |
| `k8s.io/apimachinery/pkg/api/errors` | 5 (`HasStatusCause`, `IsTimeout`, `NewConflict`, `NewInternalError`, `opaqueInitsOk`) | 5 | the checks read a `*StatusError` only; the constructors leave out the message |
| `k8s.io/apimachinery/pkg/labels` | 2 (`Everything`, `opaqueInitsOk`) | 2 | the shared selectors without their package variables; `Empty`/`Matches` are the real code |
| `k8s.io/apimachinery/pkg/apis/meta/v1` | 4 (`LabelSelectorAsSelector`, the predicate `labels.reqsValid`, `opaqueInitsOk`, `initFuncsOk`) | 4 | only the empty selector is accepted (`reqsValid`: no pair, no requirement); the two `init()`s register nothing in the package's scheme |
| `k8s.io/api/core/v1`, `apps/v1` | 7 (`Resource` ×2, `DeepCopyObject` of `Node`, `Pod`, `DaemonSet`, `opaqueInitsOk` ×2) | 4 | `DeepCopyObject` not modelled: see below; `ControllerRevision.DeepCopyObject` **verified in etcd-grove** (`4fcdd2aa9d`) |
| `k8s.io/apiserver/pkg/storage/etcd3/metrics` | 9 (`NewEtcdMetricsTracker`, `OperationLatencyTracker.Record`, 6 `Record*`, `opaqueInitsOk`) | 9 | no metrics; `ErrTransactionConflict` translated and proved in etcd-grove since `1ed1c7f480` (its `errorsNewVarsInit` gone); `NewEtcdMetricsTracker` met since etcd-grove `4fcdd2aa9d` translates `OperationLatencyTracker`: see below |
| `k8s.io/component-base/metrics` | 3 (`HistogramVec.WithContext`, `opaqueInitsOk`, `initFuncsOk`; `vecLabels`, `histCtxOk` are its vocabulary) | 3 | nil wrappers and observers that record nothing; the `init()` records no process start time |

### Package initialization

The packages whose only modelled axioms are the initialization axioms etcd-grove's `etc/gen-init.py`
generates (`Refimpl/<pkg>/Init.lean`; packages with function models are in the table above):

- `opaqueInitsOk`: every listed untranslated initializer `X.init` is `initNoop`. This is sound with
  respect to etcd-grove's other axioms: `gen-init.py` leaves out of the list every variable a spec
  relies on, whose initializer has an axiom of its own (`X_init`, giving its value: rpctypes' client
  errors, rafthttp's `linkHeartbeatSize`, ...), which these models do not cover.
- `initFuncsOk`: the package's `init()`s are Go, translated from a copy of the package's source
  (`go/third_party/`, `go-k8s/third_party/`) with empty bodies (`// refimpl:` on the `func init()`
  line, the real body commented out line by line, so that every line number is the real one; an
  import left unused is made blank, so that the package still imports it). As the post is `True`,
  no other axiom can rely on what a real `init()` does. etcd's own packages are in
  `go/third_party/etcd/`: the five Go modules (`api`, `client/pkg`, `client/v3`, `pkg`, `server`)
  of the fork etcd-grove's `etcd` project pins (`upamanyus/etcd` `8c28a4296`), without tests; its
  prophecy patches (`etc/proph-patches/etcd/`) touch only `client/v3/kubernetes`, which is not
  translated here, and are not applied.

| package | axioms | modelled | notes |
|---|---|---|---|
| `bufio` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `crypto/tls` | `opaqueInitsOk` (50 vars) | 1/1 |  |
| `encoding/base64` | `opaqueInitsOk` (2 vars) | 1/1 |  |
| `encoding/json` | `opaqueInitsOk` (4 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `github.com/Masterminds/semver/v3` | `opaqueInitsOk` (11 vars), `initFuncsOk` (2 `init()`) | 2/2 |  |
| `github.com/dustin/go-humanize` | `opaqueInitsOk` (35 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `github.com/go-logr/logr` | `opaqueInitsOk` (5 vars) | 1/1 |  |
| `github.com/spf13/pflag` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `go.etcd.io/etcd/api/v3/authpb` | `opaqueInitsOk` (4 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/api/v3/etcdserverpb` | `opaqueInitsOk` (24 vars), `initFuncsOk` (3 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/api/v3/membershippb` | `opaqueInitsOk` (3 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/api/v3/mvccpb` | `opaqueInitsOk` (6 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/api/v3/v3rpc/rpctypes` | `opaqueInitsOk` (96 vars) | 1/1 |  |
| `go.etcd.io/etcd/api/v3/version` | `opaqueInitsOk` (11 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/client/pkg/v3/logutil` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `go.etcd.io/etcd/client/pkg/v3/types` | `opaqueInitsOk` (2 vars) | 1/1 |  |
| `go.etcd.io/etcd/client/v3` | `opaqueInitsOk` (6 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/pkg/v3/featuregate` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `go.etcd.io/etcd/server/v3/auth` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/etcdserver` | `opaqueInitsOk` (2 vars), `initFuncsOk` (3 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/server/v3/etcdserver/api` | `opaqueInitsOk` (1 var), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/server/v3/etcdserver/api/membership` | `initFuncsOk` (1 `init()`) | 1/1 | its `errors.New` variables are translated and proved in etcd-grove (`f61c5c06cc`); no `opaqueInitsOk` since etcd-grove `1ed1c7f480` |
| `go.etcd.io/etcd/server/v3/etcdserver/api/rafthttp` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `101733cb0e` (its variables translated), no `errorsNewVarsInit` since etcd-grove `1ed1c7f480` (its `errors.New` variables translated and proved) |
| `go.etcd.io/etcd/server/v3/etcdserver/api/snap` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/etcdserver/api/v3rpc` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/etcdserver/apply` | `initFuncsOk` (1 `init()`) | 1/1 |  |
| `go.etcd.io/etcd/server/v3/etcdserver/txn` | `opaqueInitsOk` (2 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/server/v3/features` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `go.etcd.io/etcd/server/v3/lease` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/lease/leasepb` | `opaqueInitsOk` (3 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/server/v3/storage` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/storage/backend` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/storage/mvcc` | `initFuncsOk` (1 `init()`) | 1/1 | no `opaqueInitsOk` since etcd-grove `1ed1c7f480` (its variables translated) |
| `go.etcd.io/etcd/server/v3/storage/schema` | `opaqueInitsOk` (4 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `go.etcd.io/etcd/server/v3/storage/wal` | `initFuncsOk` (1 `init()`) | 1/1 |  |
| `go.etcd.io/etcd/server/v3/storage/wal/walpb` | `opaqueInitsOk` (3 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `golang.org/x/crypto/bcrypt` | `opaqueInitsOk` (5 vars) | 1/1 |  |
| `golang.org/x/sys/unix` | `opaqueInitsOk` (11 vars) | 1/1 |  |
| `google.golang.org/grpc` | `opaqueInitsOk` (38 vars), `initFuncsOk` (6 `init()`) | 2/2 |  |
| `google.golang.org/grpc/credentials` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `google.golang.org/grpc/grpclog` | `opaqueInitsOk` (1 var), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `google.golang.org/grpc/reflection` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `hash/crc32` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `internal/bytealg` | `initFuncsOk` (1 `init()`) | 1/1 |  |
| `internal/runtime/sys` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/api/meta` | `opaqueInitsOk` (24 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/api/validate/content` | `opaqueInitsOk` (10 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/apis/meta/v1/unstructured` | `opaqueInitsOk` (7 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/conversion` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `k8s.io/apimachinery/pkg/fields` | `opaqueInitsOk` (2 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/runtime` | `opaqueInitsOk` (27 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/runtime/schema` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `k8s.io/apimachinery/pkg/util/errors` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `k8s.io/apimachinery/pkg/util/runtime` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/util/validation/field` | `opaqueInitsOk` (2 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/util/version` | `opaqueInitsOk` (2 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/util/wait` | `opaqueInitsOk` (8 vars) | 1/1 |  |
| `k8s.io/apimachinery/pkg/watch` | `opaqueInitsOk` (6 vars) | 1/1 |  |
| `k8s.io/apiserver/pkg/audit` | `opaqueInitsOk` (6 vars), `initFuncsOk` (2 `init()`) | 2/2 |  |
| `k8s.io/apiserver/pkg/endpoints/request` | `opaqueInitsOk` (5 vars) | 1/1 |  |
| `k8s.io/apiserver/pkg/features` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `k8s.io/apiserver/pkg/storage/feature` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `k8s.io/apiserver/pkg/storage/value` | `opaqueInitsOk` (6 vars), `initFuncsOk` (1 `init()`) | 2/2 |  |
| `k8s.io/apiserver/pkg/util/flowcontrol` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `k8s.io/component-base/featuregate` | `opaqueInitsOk` (6 vars) | 1/1 |  |
| `k8s.io/utils/clock` | `opaqueInitsOk` (2 vars) | 1/1 |  |
| `math/rand` | `opaqueInitsOk` (9 vars) | 1/1 |  |
| `net` | `opaqueInitsOk` (78 vars) | 1/1 |  |
| `net/http` | `opaqueInitsOk` (116 vars), `initFuncsOk` (2 `init()`) | 2/2 |  |
| `net/url` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `path` | `opaqueInitsOk` (1 var) | 1/1 |  |
| `path/filepath` | `opaqueInitsOk` (3 vars) | 1/1 |  |
| `reflect` | `opaqueInitsOk` (7 vars) | 1/1 |  |
| `runtime` | `opaqueInitsOk` (94 vars), `initFuncsOk` (9 `init()`) | 1/2 | `initFuncsOk` blocked: Perennial translates `runtime` from another Go release (Findings) |

### Findings

- **`runtime`'s `initFuncsOk` is not modelled: Perennial's translation of `runtime` is of another Go
  release than the toolchain etcd-grove pins.** etcd-grove's `runtime` axioms (`opaqueInitsOk`,
  `initFuncsOk` over `init.«0»`..`init.«8»`) are about Perennial's `Perennial/Code/runtime`, which is
  not in etcd-grove's `Code/`, so the pure-superset comparison does not apply; and translating
  go1.27.3's `runtime` (etcd-grove's `GO_TOOLCHAIN`) with Perennial's configuration gives a different
  translation, not a superset: Perennial's has struct fields go1.27.3 does not (`_panic.gopanicFP`,
  `memRecordCycle`'s `alloc_bytes`), which go1.26's `runtime` has. Both releases have nine `init()`s
  on linux/amd64, so the axiom's list is right for either. A model needs `etc/goose-refimpl.py` to
  compare against Perennial's chunked translation, from the toolchain Perennial translated `runtime`
  with. (`runtime`'s `opaqueInitsOk` is modelled: it needs no Go.)

- **`otelgrpc.NewServerHandler` could not be met in etcd-grove's translation as configured (fixed in
  etcd-grove `9d1d50a846`, 2026-11-19: grpc's `stats` types translated, imported by otelgrpc's
  configuration; now modelled).** As `grpc_prometheus.NewServerMetrics` could not: any Go body returns
  a `stats.Handler`, and Goose allocates the result (`GoAlloc stats.Handler.ty`, then `Convert` into
  it), but etcd-grove did not translate grpc's `stats` package at all, so the translated body named
  `google_golang_org.grpc.stats.Handler.ty`, which did not exist. The reference implementation
  (`go/third_party/otelgrpc`, v0.71.0, etcd's pin) returns a nil handler, which grpc's `StatsHandler`
  option ignores (`server.go`: "ignoring nil parameter in grpc.StatsHandler ServerOption"); the model
  of `grpcStatsHandlerOk h` is "`h` is the nil interface", under which grpc's `StatsHandler` axiom, the
  predicate's only consumer, holds of the real grpc (that axiom is grpc's, not modelled here).

- **`k8s.io/utils/trace`'s `Trace.LogIfLong` spec was false of the real code (fixed in etcd-grove
  `4fcdd2aa9d`: `Step` and `LogIfLong` require `trace.fromNew t`, which `New` gives; modelled as
  `True`)** (satisfiable: the model met it). It holds for every `t : Loc` with no premise (`{{ True }} t.LogIfLong(d) {{ True }}`), but
  the real `LogIfLong` (k8s.io/utils `be93311217bd`, `trace/trace.go:208`) starts with `t.lock.Lock()`:
  `var t *trace.Trace; t.LogIfLong(time.Second)` panics with a nil dereference (run with Go 1.27.3),
  yet the axiom proves it returns. Any location that is not a live `*Trace` is admitted too. Fix in
  etcd-grove: a predicate of the traces `trace.New` returns (persistent: `Trace` has its own lock),
  produced by `New`'s spec and required by `LogIfLong`'s; the named hypothesis `Trace.Step` has the
  same gap.

- **The k8s API types' `DeepCopyObject` (core/v1 `Node`, `Pod`; apps/v1 `DaemonSet`): not modelled**
  (`ControllerRevision`'s is a theorem in etcd-grove `4fcdd2aa9d`, over deepcopy-gen's code
  translated with generated proofs; the other three are still axioms there). The spec gives the caller a new object owned whole (`l' ↦ v'` and
  `kd.*.own v' (DFrac.own 1) d`, every slice and map reached fresh) with the original's deep value,
  so any implementation is a complete deep copy over the 166 struct types of etcd-grove's
  `Proof/k8s_io/api/Deep.lean`: the real, generated `DeepCopyInto` is already the simplest one. Its
  proof is mechanical and belongs in etcd-grove, generated alongside `Deep.lean`
  (`etc/gen-k8s-deep.py`), with the deep copies translated with their bodies; the axioms are believed
  true.
- **`metrics.NewEtcdMetricsTracker` could not be met in etcd-grove's translation as configured
  (fixed in etcd-grove `4fcdd2aa9d`, which imports `schema` and component-base's `metrics`; now
  modelled).** It
  returns a tracker whose `Get` is a non-nil `*OperationLatencyTracker`; any Go code doing so
  allocates an `OperationLatencyTracker`, a type etcd-grove's translation axiomatizes (its fields name
  `schema.GroupResource` and component-base's `metrics.ObserverMetric`/`CounterMetric`, and the
  package's configuration imports neither), so the allocation is stuck on `sorry` instances, as
  `ServerMetrics`'s was. Fix in etcd-grove: import `k8s.io/apimachinery/pkg/runtime/schema` and
  `k8s.io/component-base/metrics` in `Code/k8s_io/apiserver/pkg/storage/etcd3/metrics.toml`, with
  component-base's `metrics.toml` translating the two interface types (it has no `translate_types`).
  The Go reference implementation and its translation are here already.
- **The apierrors specs after etcd-grove's `apierrors-fix` (2026-11-17) are satisfiable.** The
  soundness review of 2026-11-17 refuted `HasStatusCause` (a view built after the call,
  `notes/hasstatuscause-later-view.md`) and the constructors' preconditions
  (`notes/axiom-review/apierrors-fix.md`); the texts this repository proves are the fixed ones. The
  models of `HasStatusCause` and `IsTimeout` rest on `apiErrOk` holding the details read-only: an error
  has one view (`apiErrAt_agree`, `Refimpl/k8s_io/apimachinery/pkg/api/errors/View.lean`), so the
  answer computed from the view held is every view's.
- **`labels.reqsValid` is uninterpreted, so `LabelSelectorAsSelector`'s spec is met by a function that
  rejects every non-empty selector.** The model is that function. The spec says nothing of which
  selectors the real code accepts (`SelDefs.lean` documents it in prose: the four operators, and
  `labels.NewRequirement`'s syntax checks); a caller can only learn it from an error.
- **`grpc_prometheus.NewServerMetrics` could not be met in etcd-grove's translation as configured
  (fixed in etcd-grove `2040eeb525`, 2026-11-18; now modelled).** It
  returns a non-nil `*ServerMetrics`; any Go code doing so allocates a `ServerMetrics`, but etcd-grove's
  Goose configuration of the package does not import prometheus, whose types the struct's fields name,
  so the type is axiomatized (`axiom ServerMetrics : Type`) and its allocation's instances are
  `sorry` (an `unsafe.Pointer` conversion is stuck: not a plain type). The axiom is true of the real
  code; what blocks a proof is the translation. Fix in etcd-grove: import prometheus's names in
  `Code/github_com/grpc_ecosystem/go_grpc_middleware/providers/prometheus.toml`.
- **`prometheus.HistogramVec.WithLabelValues` could not be met by any implementation (`observerSpec`;
  fixed in etcd-grove `4fcdd2aa9d`, `∀ f : w64`; now modelled).**
  Its post gives `observerSpec oi`, which says `{{ True }} methods oi.ty "Observe" oi.v f {{ RET #(); True }}`
  for every `f : val`. Take `f := PanicV p`, a panic outcome: GooseLang evaluates an application's
  argument first, and a panic in that position unwinds the application (`Unwinds`, the `AppRCtx`
  frame), so the call evaluates to `PanicV p` whatever the method is, and the triple's
  postcondition (`Φ #()`) cannot be met for it (take `Φ v := ⌜v = #()⌝`). The axiom is therefore false
  in every model, not only of the real code (whose `Observe(v float64)` would in addition be stuck
  allocating a `float64` from any value that is not a 64-bit word). Every caller passes a float64
  (`EtcdServer.Range`/`Txn`, `processInternalRaftRequestOnce`, rafthttp's snapshot sender and
  handler), so the fix in etcd-grove is `∀ f : w64` (`#f`) in `observerSpec`, as `gaugeSpec`'s `Add`
  and `GaugeVec.With`'s `Set` already have. (Not checked for: whether the false axiom lets
  etcd-grove prove `False` outright; it needs a vector with `vecLabels`, which its initializer axioms
  give.)
- **`prometheus.wp_counterOptsLit` (fixed in etcd-grove `2040eeb525`).** `CounterOpts = Opts` was an
  axiomatized type (its field `now func() time.Time`, with `time` not imported), so the composite
  literal had no semantics, whatever the implementation. etcd-grove now imports `time` in the
  package's Goose configuration; `counterOpts` is a definition and the literal's axiom is gone.
- **grpc's `status.Error`, `status.FromError` and `metadata.AppendToOutgoingContext` cannot be met by
  any implementation that returns.** Each post equates an opaque Lean function of a Go value with data
  the caller chooses, for a value the function allocates or whose method it calls:
  - `status.Error(c, msg)`: `errDesc err = msg` for every `msg`, where `err` is a `*status.Error` (the
    post fixes its type), so its value is a location: one the call does not allocate cannot have every
    `msg` as its description, and one it allocates may be any fresh location;
  - `status.FromError(err)` with `ok = false`: `errDesc err = m`, where `m` is the precondition's
    string, which `err.Error()` returns (`errorMsgIs`): the same error value can return `"a"` in one
    heap and `"b"` in another (an `Error()` that reads a cell);
  - `metadata.AppendToOutgoingContext(ctx, [k, v])`: `outgoingOf c' = mdAdd (outgoingOf ctx) k v`, for
    the context `c'` it returns: a fresh `*valueCtx` (returning `ctx` itself would need
    `outgoingOf ctx = mdAdd (outgoingOf ctx) k v`, false: `mdAdd` appends `v`).

  `errDesc` and `outgoingOf` are fixed Lean functions, the same in every execution, while the location
  an allocation returns is any fresh one (GooseLang's `Alloc`/`AllocBytes` steps), and the contents of a
  cell are the initial heap's. A model proof is one proof for every location and every heap, so no
  definition of `errDesc` or `outgoingOf` makes the post provable, whatever the code (short of code
  that never returns). The axioms are false of grpc itself in the same way: two runs of
  `status.Error(c, "a")` and `status.Error(c, "b")` from the same heap may allocate the same location,
  so by adequacy `errDesc` of one value would be both `"a"` and `"b"`. etcd-grove documents the reading
  it intends (`status.FromError.spec`'s docstring, `incomingOf_cancelCtx`'s: "the equations are claims
  about one execution's heap"), but the Lean statements do not say it: the functions do not depend on
  the execution. A fix in etcd-grove would make the description and the metadata ghost state of the
  execution (for example a persistent `errDescIs err m` points-to-like fact, given by `status.Error`
  and read by `FromError`) instead of functions of the value.
- **grpc health's `Server.SetServingStatus` and `HealthCheckResponse_ServingStatus.String` could not be
  met by any implementation (fixed in etcd-grove `4fcdd2aa9d`, the status a `w32`; now modelled).** Their specs take the serving status as any `val`, not a `w32`. A `val` may be
  a panic outcome `PanicV p`, and an application to one unwinds to `PanicV p` in one pure step
  (GooseLang's `Unwinds`, Perennial's `pure_unwind`), whatever the function: the result is not the
  `RET #()` (`RET #s`) the post names. `String`'s precondition is `True`, so its axiom, at
  `st := PanicV p`, gives a WP no execution satisfies (by adequacy, `False`); `SetServingStatus`'s
  does the same under `grpcHealthSrv hs`, which `health.NewServer`'s axiom gives. (Short of a panic,
  the real code is stuck too on a `val` that is not an `int32`: Goose stores a named parameter with
  `GoAlloc`, `AllocBytes 4` for an `int32`.) Fix in etcd-grove: quantify over `w32`. The Go model
  (`go/third_party/grpc`) leaves the parameters unnamed, so that it meets the fixed specs.
- **`health.NewServer` cannot be met in etcd-grove's translation as configured**, as
  `grpc_prometheus.NewServerMetrics` could not: it returns a non-nil `*health.Server`, and `Server` is
  an axiomatized type, so `&Server{}` is stuck. etcd-grove `2040eeb525` turned on `translate_types` for
  `health` (importing `sync` and `grpc_health_v1`), but Goose still axiomatizes `Server`: its field
  `updates map[string]map[healthgrpc.Health_WatchServer]chan ...` names `Health_WatchServer`, an alias
  (of the generic `grpc.ServerStreamingServer[HealthCheckResponse]`) declared in another package
  (`GOOSE_TYPES_LOG`: "alias from another package google.golang.org/grpc/health/grpc_health_v1; needs
  import google.golang.org/grpc"; with `google.golang.org/grpc` imported too, still "alias from another
  package"). The fix is in Goose (Perennial): translate a field type that is another package's alias.
- **`grpc_health_v1.RegisterHealthServer` is not modelled here**: its post is a new `grpcSrvNew` (grpc's
  server being built, an opaque predicate), which only grpc's own `Server.RegisterService` axiom gives;
  a model proof may not use it. grpc's body is `srv.testEmbeddedByValue(); s.RegisterService(&Health_ServiceDesc,
  srv)`, provable in etcd-grove from `Server.RegisterService.spec` once `Health_ServiceDesc`'s
  initializer is translated. (`metadata.MD.Get`, `md[strings.ToLower(k)]`, is now proved there:
  `4fcdd2aa9d`.)

- **Perennial: no `go.NotInterface` instance for the predeclared types.** Resolving a method on a
  value receiver of a named non-struct type (`HealthCheckResponse_ServingStatus`, an `int32`) needs
  `go.NotInterface` of its underlying type; Perennial has instances for the type constructors
  (`go.Named`, `go.PointerType`, ...) but `go.int32` is a plain `def`, which instance search does not
  unfold, so `wp_auto` makes no progress. The model proof supplies `haveI : go.NotInterface go.int32
  := ⟨trivial⟩`; the general fix is an instance per predeclared type in Perennial
  (`Golang/Theory/PostLifting.lean`).
- **`metrics.RecordDecodeError` was not modelled (this repository, fixed with the `4fcdd2aa9d` pin).**
  The row counted 7 axioms; etcd-grove has 8 (`RecordDecodeError` had been missed). Its model records
  nothing, like the other `Record*`.

- **`model%` and universe-polymorphic constants (this repository).** `promSrvMetrics` is declared
  with `{GF : BundledGFunctors}` and nothing fixing its universe; `model%` now takes a polymorphic
  constant's model as a constant with the same universe parameters, replaced at each occurrence's
  levels.

- **`model%` left a substitution undone (this repository, fixed 2026-11-18).** Classifying the definitions
  that mention a replaced constant stopped at a definition's first such constant, so a second one
  (`rate.reservationOk`, after `rate.limiterOk` in `Limiter.Reserve.spec`) was neither unfolded nor
  replaced, and the check for leftovers looked only at the statement's own constants. Both fixed
  (every constant classified; the check follows definitions). Earlier results were not affected: a
  leftover opaque predicate can only make a proof harder, and its laws are axioms `#model_check`
  rejects; every earlier model proof still checks.

- **clockwork's `stampAt` (a docstring only).** etcd-grove's `Proof/github_com/jonboulle/clockwork/Defs.lean`
  says the clock axioms have the trivial model `clockLb := True`, `stampAt P T := P`. That model fails
  `stampAt_persistent`, which makes every stamp persistent, for a `P` that is not. The axioms are
  satisfiable all the same, with `stampAt P T := □ P` (this repository's model); no axiom changes.

- **`zap.Logger.Panic` (fixed in etcd-grove, 2026-11-17, `notes/specs-only/ledger.md`).**
  - **The panic value.** The spec said `r = PanicV #msg`, a panic with the bare string. No Go program
    raises that: Go's `panic(x)` (Perennial's `go.panic`) panics with an interface value,
    `PanicV #(interface.mkOk go.string #msg)`, and zap's `WriteThenPanic` does `panic(ce.Message)`. The
    model could meet the old spec only with GooseLang's raw `Raise`. The spec now names the interface
    value, and so do the mvcc `keyIndex` specs that had copied the bare string; the model is Go's
    `panic(msg)`.
  - **The premise.** It was `l ≠ null`, which admits loggers for which the axiom is false of real zap. A
    zero `&zap.Logger{}` panics with a nil-dereference runtime error, not `msg`. A logger built with a
    custom `WithPanicHook` whose hook returns makes `Panic` return. The premise is now `zapLoggerOk l`,
    as for the other logging methods, and the mvcc callers pass it on from their index's invariant.

## Building

`lakefile.toml` requires etcd-grove at a pinned commit. A plain `lake build` clones it and builds
it from scratch (hours): don't. Build against an existing, built checkout of etcd-grove at that commit,
with Lake's artifact cache on:

```sh
export LAKE_ARTIFACT_CACHE=true LAKE_RESTORE_ARTIFACTS=true
etc/link-local.sh /path/to/etcd-grove
etc/goose-refimpl.py --check   # the Go reference implementations translate to Refimpl/Gen/
lake build
```

`etc/lean-check.py FILE` (copied from etcd-grove) checks a file through a persistent Lean server,
for the edit-check loop.
