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
- `go-k8s/`: the same for the packages of etcd-grove's `k8s-apiserver` Goose project (klog,
  component-base's `tracing`), a module of its own because that project's dependencies are pinned
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
| `go.opentelemetry.io/otel/trace` | 2 function specs (`SpanFromContext`, `WithAttributes`) | 1 | `SpanFromContext` returns the no-op span; `WithAttributes`'s real code is plainly provable: to etcd-grove |
| `go.opentelemetry.io/otel/attribute` | 4 (`Bool`, `Int`, `Int64`, `String`) | 0 | the real code is plainly provable (a struct literal): to etcd-grove |
| `k8s.io/utils/trace` | 2 (`New`, `Trace.LogIfLong`) | 2 | a nil trace, logging nothing; `LogIfLong`'s spec is false of the real code: see below |
| `github.com/xiang90/probing` | 2 (`NewHandler`, `NewProber`) | 2 | an empty `200` handler (relative to net/http's `WriteHeader` spec) and a nil prober |
| `github.com/prometheus/client_golang/prometheus` | 12 (7 function specs, `opaqueInitsOk`, `initFuncsOk`; `collectorName`/`nameFree`/`nameUnclaimed` are the predicates) | 11 | a registry that registers nothing, metrics (nil pointers) that record nothing; `HistogramVec.WithLabelValues` is unsatisfiable (`observerSpec`): see below; `Opts` translated in etcd-grove (`2040eeb525`) |
| `google.golang.org/grpc/status` (and `internal/status`'s `Status.Code`) | 5 | 3 | every code `Unknown`; `Error`, `FromError`: **no implementation meets them**, see below |
| `google.golang.org/grpc/metadata` | 7 (4 function specs, `incomingOf_cancelCtx`, `opaqueInitsOk`, `initFuncsOk`) | 5 | no context carries metadata; `MD.Get`: grpc's code is provable in etcd-grove; `AppendToOutgoingContext`: **no implementation meets it**, see below |
| `google.golang.org/grpc/health`, `health/grpc_health_v1` | 9 (4 function specs, `grpcHealthSrv_persistent`, `opaqueInitsOk` ×2, `initFuncsOk` ×2) | 7 | a health server that records nothing; `NewServer` blocked by an axiomatized type, `RegisterHealthServer` by grpc's server model: see below |

### Findings

- **`k8s.io/utils/trace`'s `Trace.LogIfLong` spec is false of the real code** (satisfiable: the model
  meets it). It holds for every `t : Loc` with no premise (`{{ True }} t.LogIfLong(d) {{ True }}`), but
  the real `LogIfLong` (k8s.io/utils `be93311217bd`, `trace/trace.go:208`) starts with `t.lock.Lock()`:
  `var t *trace.Trace; t.LogIfLong(time.Second)` panics with a nil dereference (run with Go 1.27.3),
  yet the axiom proves it returns. Any location that is not a live `*Trace` is admitted too. Fix in
  etcd-grove: a predicate of the traces `trace.New` returns (persistent: `Trace` has its own lock),
  produced by `New`'s spec and required by `LogIfLong`'s; the named hypothesis `Trace.Step` has the
  same gap.

- **`grpc_prometheus.NewServerMetrics` could not be met in etcd-grove's translation as configured
  (fixed in etcd-grove `2040eeb525`, 2026-11-18; now modelled).** It
  returns a non-nil `*ServerMetrics`; any Go code doing so allocates a `ServerMetrics`, but etcd-grove's
  Goose configuration of the package does not import prometheus, whose types the struct's fields name,
  so the type is axiomatized (`axiom ServerMetrics : Type`) and its allocation's instances are
  `sorry` (an `unsafe.Pointer` conversion is stuck: not a plain type). The axiom is true of the real
  code; what blocks a proof is the translation. Fix in etcd-grove: import prometheus's names in
  `Code/github_com/grpc_ecosystem/go_grpc_middleware/providers/prometheus.toml`.
- **`prometheus.HistogramVec.WithLabelValues` cannot be met by any implementation (`observerSpec`).**
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
- **Specs over an arbitrary `val` (grpc's health).** `health.Server.SetServingStatus.spec` and
  `grpc_health_v1.HealthCheckResponse_ServingStatus.String.spec` take the serving status as any `val`,
  not a `w32`. Goose stores a named parameter or receiver in a variable of its type (`GoAlloc`), which
  for an `int32` is `AllocBytes 4`, stuck on a `val` that is not a 32-bit literal: the axioms are false
  of grpc's translated code for such a `val` (no Go program passes one, so nothing unsound follows for
  Go code). The model's methods leave the parameter unnamed (nothing stored); the specs should take
  `w32`.
- **`health.NewServer` cannot be met in etcd-grove's translation as configured**, as
  `grpc_prometheus.NewServerMetrics` could not: it returns a non-nil `*health.Server`, and etcd-grove's
  Goose configuration of `health` (`Code/google_golang_org/grpc/health.toml`) translates no types, so
  `Server` is axiomatized and `&Server{}` is stuck. Fix in etcd-grove: `translate_types = true`, with
  the imports `Server`'s fields name (`sync`, `google.golang.org/grpc/health/grpc_health_v1`).
- **`grpc_health_v1.RegisterHealthServer` is not modelled here**: its post is a new `grpcSrvNew` (grpc's
  server being built, an opaque predicate), which only grpc's own `Server.RegisterService` axiom gives;
  a model proof may not use it. grpc's body is `srv.testEmbeddedByValue(); s.RegisterService(&Health_ServiceDesc,
  srv)`, provable in etcd-grove from `Server.RegisterService.spec` once `Health_ServiceDesc`'s
  initializer is translated; so is `metadata.MD.Get` (`md[strings.ToLower(k)]`, over etcd-grove's
  `strings.ToLower` spec).

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
