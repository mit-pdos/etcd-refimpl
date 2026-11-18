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
- `go/goose-config/`: the Goose configuration of those packages: etcd-grove's
  (`Code/**/*.toml`), plus the replaced functions in `translate`.
- `etc/goose-refimpl.py` runs the pinned Goose (built from the pinned Perennial) on `go/` with the
  etcd project's `-lean-root` arguments, and compares the output with etcd-grove's checked-in
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
| `go-grpc-middleware/providers/prometheus` | 7 (5 function specs, `promSrvMetrics_persistent`; `promSrvMetrics`/`promSrvMetricsOpt` are the predicates) | 6 | `NewServerMetrics` blocked by an axiomatized type: see below |

### Findings

- **`grpc_prometheus.NewServerMetrics` cannot be met in etcd-grove's translation as configured.** It
  returns a non-nil `*ServerMetrics`; any Go code doing so allocates a `ServerMetrics`, but etcd-grove's
  Goose configuration of the package does not import prometheus, whose types the struct's fields name,
  so the type is axiomatized (`axiom ServerMetrics : Type`) and its allocation's instances are
  `sorry` (an `unsafe.Pointer` conversion is stuck: not a plain type). The axiom is true of the real
  code; what blocks a proof is the translation. Fix in etcd-grove: import prometheus's names in
  `Code/github_com/grpc_ecosystem/go_grpc_middleware/providers/prometheus.toml`.
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
