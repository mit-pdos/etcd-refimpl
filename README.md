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
  model, as theorems (zapcore's `init()` is Go too).
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
| `go.opentelemetry.io/otel/trace` | 1 function spec (`SpanFromContext`) | 1 | `SpanFromContext` returns the no-op span; `WithAttributes` **verified in etcd-grove** (`4fcdd2aa9d`: the real body translated, its axiom a theorem) |
| `go.opentelemetry.io/otel/attribute` | 4 (`Bool`, `Int`, `Int64`, `String`) | moved | **verified in etcd-grove** (`4fcdd2aa9d`): the real code translated, the 4 axioms are theorems there |
| `k8s.io/utils/trace` | 2 (`New`, `Trace.LogIfLong`; the predicate `trace.fromNew`) | 2 | a nil trace, logging nothing; `fromNew := True`. `LogIfLong`'s spec, false of the real code, fixed in etcd-grove `4fcdd2aa9d`: see below |
| `github.com/xiang90/probing` | 2 (`NewHandler`, `NewProber`) | 2 | an empty `200` handler (relative to net/http's `WriteHeader` spec) and a nil prober |
| `github.com/prometheus/client_golang/prometheus` | 12 (7 function specs, `opaqueInitsOk`, `initFuncsOk`; `collectorName`/`nameFree`/`nameUnclaimed` are the predicates) | 12 | a registry that registers nothing, metrics (nil pointers) that record nothing; `HistogramVec.WithLabelValues` was unsatisfiable (`observerSpec`), fixed in etcd-grove `4fcdd2aa9d`: see below; `Opts` translated in etcd-grove (`2040eeb525`) |
| `google.golang.org/grpc/status` (and `internal/status`'s `Status.Code`) | 5 | 3 | every code `Unknown`; `Error`, `FromError`: **no implementation meets them**, see below |
| `google.golang.org/grpc/metadata` | 6 (3 function specs, `incomingOf_cancelCtx`, `opaqueInitsOk`, `initFuncsOk`) | 5 | no context carries metadata; `MD.Get` **verified in etcd-grove** (`4fcdd2aa9d`); `AppendToOutgoingContext`: **no implementation meets it**, see below |
| `google.golang.org/grpc/health`, `health/grpc_health_v1` | 9 (4 function specs, `grpcHealthSrv_persistent`, `opaqueInitsOk` ×2, `initFuncsOk` ×2) | 7 | a health server that records nothing; `SetServingStatus`, `ServingStatus.String` met since etcd-grove `4fcdd2aa9d` (a `w32` status); `NewServer` blocked by an axiomatized type, `RegisterHealthServer` by grpc's server model: see below |
| `k8s.io/apimachinery/pkg/api/errors` | 4 (`HasStatusCause`, `IsTimeout`, `NewConflict`, `NewInternalError`) | 4 | the checks read a `*StatusError` only; the constructors leave out the message |
| `k8s.io/apimachinery/pkg/labels` | 1 (`Everything`) | 1 | the shared selectors without their package variables; `Empty`/`Matches` are the real code |
| `k8s.io/apimachinery/pkg/apis/meta/v1` | 2 (`LabelSelectorAsSelector`, the predicate `labels.reqsValid`) | 2 | only the empty selector is accepted (`reqsValid`: no pair, no requirement) |
| `k8s.io/api/core/v1`, `apps/v1` | 5 (`Resource` ×2, `DeepCopyObject` of `Node`, `Pod`, `DaemonSet`) | 2 | `DeepCopyObject` not modelled: see below; `ControllerRevision.DeepCopyObject` **verified in etcd-grove** (`4fcdd2aa9d`) |
| `k8s.io/apiserver/pkg/storage/etcd3/metrics` | 8 (`NewEtcdMetricsTracker`, `OperationLatencyTracker.Record`, 6 `Record*`) | 8 | no metrics; `NewEtcdMetricsTracker` met since etcd-grove `4fcdd2aa9d` translates `OperationLatencyTracker`: see below |

### Findings

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
