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

One directory per Go package, as in etcd-grove (`Refimpl/<go package path>/`):

- `Impl.lean`: the package's model:
  - the reference implementation of each axiomatized function, as GooseLang code (each with the Go
    it stands for in its docstring);
  - definitions of the opaque predicates and values the axioms are written in (in zap,
    `zap.loggerRaw`, `zapcore.zapEntry`, the untranslated initializers `X.init`);
  - `<pkg>.Bound`, the class binding the package's function and method names to that code
    (`FuncUnfold`/`MethodUnfold`, the facts the generated `Assumptions` give for translated code).
- `<fn>.lean`, one per axiomatized function (the name of etcd-grove's spec file,
  `Spec/<pkg>/<fn>.lean`): `theorem <fn>.model_proof`, the spec, read in the model, proved of the
  reference implementation, under `[<pkg>.Bound]`.
- `Init.lean`: the package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`), read in the
  model, as theorems.
- `Results.lean`: `#model_check` of every model proof of the package.

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
`[<pkg>.Bound]`, saying that the function names are bound to the reference implementation. Each
proof therefore shows that the axiom is *satisfiable*: it holds of a program in which the library is
the reference implementation. It does not show that the axiom holds of the real library, and the
real Go code is not checked here. The models are deliberately the simplest implementations that
meet the specs: a logger that discards everything, field constructors that return `Field{}`, and
initializers that do nothing.

## Status

| package | axioms | modelled | notes |
|---|---|---|---|
| `go.uber.org/zap`, `zap/zapcore` | 26 (23 function specs, `CheckedEntry.Write`, `opaqueInitsOk` ×2, `initFuncsOk`) | 26 | `Logger.Panic`: see below |

### Findings

- **`zap.Logger.Panic`'s spec names a panic value no Go program raises.** Its post is
  `r = PanicV #msg`, a panic with the bare string. Go's `panic(x)` (Perennial's `go.panic`) panics
  with an interface value, `PanicV #(interface.mkOk go.string #msg)`, and zap's `WriteThenPanic` does
  `panic(ce.Message)`. The model meets the spec only with GooseLang's raw `Raise msg`, which no Go
  source translates to. The proofs that use the spec (mvcc's `keyIndex`, `backend.newBackend`, the
  apply path) only need that it panics; the fix is to state the interface value (or
  `∃ p, r = PanicV p`) in etcd-grove's `Spec/go_uber_org/zap/Logger__Panic.lean`.

## Building

`lakefile.toml` requires etcd-grove at a pinned commit. A plain `lake build` clones it and builds
it from scratch (hours). To build against an existing, built checkout of etcd-grove at that commit:

```sh
etc/link-local.sh /path/to/etcd-grove
lake build
```

`etc/lean-check.py FILE` (copied from etcd-grove) checks a file through a persistent Lean server,
for the edit-check loop.
