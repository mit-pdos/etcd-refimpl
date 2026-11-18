/-
A model of zap's trust boundary (`go.uber.org/zap` and `go.uber.org/zap/zapcore`, names-only in
etcd-grove's translation; this repository's README).

The reference implementation is Go: `go/third_party/zap`, zap v1.28.0 (etcd's pin) with the bodies
of the functions etcd calls replaced (each marked `// refimpl:`), a logger that discards everything:

```go
func NewNop() *Logger                                   { return &Logger{} }
func (log *Logger) Debug(msg string, fields ...Field)  {}   // and Info, Warn, Error
func (log *Logger) Check(lvl zapcore.Level, msg string) *zapcore.CheckedEntry { return nil }
func (log *Logger) Panic(msg string, fields ...Field)  { panic(msg) }
func (log *Logger) Fatal(msg string, fields ...Field)  { for {} }  // os.Exit: never returns
func String(key string, val string) Field              { return Field{} }  // every Field constructor
func (ce *CheckedEntry) Write(fields ...Field)         {}
```

Goose translates it (`etc/goose-refimpl.py`) into `Refimpl/Gen/go_uber_org/zap{,/zapcore}.lean`:
the bodies, and the classes `go_uber_org.zap.Refimpl`/`go_uber_org.zap.zapcore.Refimpl` binding
the names to them, the hypothesis of every model proof. This file holds what is not code: the
definitions of the opaque predicates the specs are written in (`zap.loggerRaw`,
`zapcore.zapEntry`), and of the untranslated package-variable initializers (`X.init`, data axioms
of etcd-grove's translation, which a translated initializer could not replace without redeclaring
them) the packages' `opaqueInitsOk` axioms run, and zapcore's `init()`.
-/
module

public import Proof.go_uber_org.zap.PkgInit
public import Proof.go_uber_org.zap.zapcore.Init
public import Spec.go_uber_org.zap.Defs
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.go_uber_org.zap
public import Refimpl.Gen.go_uber_org.zap.zapcore

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI go_uber_org

section defs
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]

/-- `zap.loggerRaw`: every location (the model's logger methods read nothing). -/
def zap.loggerRaw (_l : Loc) : IProp GF := iprop(True)

/-- `zapcore.zapEntry`: every location (the model's `Check` returns only nil, and its `Write`
reads nothing). -/
def zapcore.zapEntry (_ce : Loc) : IProp GF := iprop(True)

end defs

end Model
end EtcdGrove
end Perennial
