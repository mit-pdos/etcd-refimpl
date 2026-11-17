/-
A model of zap's trust boundary (`go.uber.org/zap` and `go.uber.org/zap/zapcore`, names-only in the
translation; this repository's README): a reference implementation of each function whose spec is an
axiom (`Proof/go_uber_org/zap/*.lean`), definitions of the opaque predicates those specs are
written in (`zap.loggerRaw`, `zapcore.zapEntry`), and of the untranslated package-variable
initializers (`X.init`) the packages' `opaqueInitsOk` axioms run. `Refimpl/go_uber_org/zap/<fn>.lean`
proves each spec of this model.

The reference implementation is a logger that discards everything, as `zap.NewNop()`'s does:

```go
func NewNop() *Logger                                   { return &Logger{} }
func (l *Logger) Debug(msg string, fields ...Field)    {}   // and Info, Warn, Error
func (l *Logger) Check(lvl zapcore.Level, msg string) *zapcore.CheckedEntry { return nil }
func (l *Logger) Panic(msg string, fields ...Field)    { panic(msg) }
func (l *Logger) Fatal(msg string, fields ...Field)    { for {} }  // os.Exit: never returns
func String(key string, val string) Field              { return Field{} }  // every Field constructor
func (ce *CheckedEntry) Write(fields ...Field)         {}
// every untranslated variable initializer, and zapcore's init(): do nothing
```

`Panic` is Go's `panic(msg)`: a panic with `msg` as an `any` (an interface holding the string), the
value its spec names since etcd-grove's ledger entry of 2026-11-17 (README, "Findings").
-/
module

public import Proof.go_uber_org.zap.PkgInit
public import Proof.go_uber_org.zap.zapcore.Init
public import Spec.go_uber_org.zap.Defs
public import Refimpl.Subst

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI go_uber_org

section code
variable [GooseExts] [GoGlobalContext]

/-- `func NewNop() *Logger { return &Logger{} }` -/
def zap.NewNop.impl : val :=
  LamV BAnon (App (Val (GoInstruction (GoAlloc zap.Logger.ty)))
    (App (Val (GoInstruction (GoZeroVal zap.Logger.ty))) (Val #())))

/-- A logging method that logs nothing: `func (l *Logger) Info(msg string, fields ...Field) {}`. -/
def zap.Logger.discard.impl : val :=
  LamV "l" (Lam "msg" (Lam "fields" (Val #())))

/-- `func (l *Logger) Check(lvl zapcore.Level, msg string) *zapcore.CheckedEntry { return nil }` -/
def zap.Logger.Check.impl : val :=
  LamV "l" (Lam "lvl" (Lam "msg" (Val #(null : Loc))))

/-- `func (l *Logger) Panic(msg string, fields ...Field) { panic(msg) }`, as goose translates it
(the string converted to `any`, then `panic`). -/
def zap.Logger.Panic.impl : val :=
  LamV "l" (Lam "msg" (Lam "fields"
    (App (App (Val (GoInstruction (FuncResolve go.panic []))) (Val #()))
      (App (Val (GoInstruction (Convert go.string (go.GoType.InterfaceType [])))) (Var "msg")))))

/-- `for {}`, as a recursive function: never returns. -/
def hang : val := RecV "hang" BAnon (App (Var "hang") (Val #()))

/-- `func (l *Logger) Fatal(msg string, fields ...Field) { for {} }` (zap's `os.Exit(1)`: the
program does not go on). -/
def zap.Logger.Fatal.impl : val :=
  LamV "l" (Lam "msg" (Lam "fields" (App (Val hang) (Val #()))))

/-- A field constructor of one argument: `func Error(err error) Field { return Field{} }`. -/
def zap.field1.impl : val :=
  LamV "k" (Val #(zeroValDef : zap.zapcore.Field))

/-- A field constructor of two arguments: `func String(key, val string) Field { return Field{} }`. -/
def zap.field2.impl : val :=
  LamV "k" (Lam "v" (Val #(zeroValDef : zap.zapcore.Field)))

/-- `func (ce *CheckedEntry) Write(fields ...Field) {}` -/
def zapcore.CheckedEntry.Write.impl : val :=
  LamV "ce" (Lam "fields" (Val #()))

/-- An initializer that does nothing: every untranslated `X.init`, and `zapcore`'s `init()`. -/
def initNoop : val := LamV BAnon (Val #())

end code

section defs
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]

/-- `zap.loggerRaw`: every location (the model's logger methods read nothing). -/
def zap.loggerRaw (_l : Loc) : IProp GF := iprop(True)

/-- `zapcore.zapEntry`: every location (the model's `Check` returns only nil, and its `Write`
reads nothing). -/
def zapcore.zapEntry (_ce : Loc) : IProp GF := iprop(True)

/-- `for {}` never returns: any postcondition holds. -/
theorem wp_hang [GoSemanticsFunctions] [go.PreSemantics] (Φ : val → IProp GF) :
    ⊢ WP (App (Val hang) (Val #())) {{ Φ }} := by
  iloeb as IH
  unfold hang
  wp_call
  iexact IH

end defs

/-- **The model's code**: zap's function and method names bound to the reference implementation
(`FuncUnfold`/`MethodUnfold`, as the generated `Assumptions` bind a translated package's). -/
class zap.Bound [GooseExts] [GoGlobalContext] [GoSemanticsFunctions] : Prop where
  NewNop : FuncUnfold zap.NewNop [] zap.NewNop.impl
  Debug : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Debug" zap.Logger.discard.impl
  Info : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Info" zap.Logger.discard.impl
  Warn : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Warn" zap.Logger.discard.impl
  Error : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Error" zap.Logger.discard.impl
  Check : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Check" zap.Logger.Check.impl
  Panic : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Panic" zap.Logger.Panic.impl
  Fatal : MethodUnfold (go.GoType.PointerType zap.Logger.ty) go!"Fatal" zap.Logger.Fatal.impl
  Bool' : FuncUnfold zap.Bool' [] zap.field2.impl
  ByteString : FuncUnfold zap.ByteString [] zap.field2.impl
  Duration : FuncUnfold zap.Duration [] zap.field2.impl
  Error' : FuncUnfold zap.Error [] zap.field1.impl
  Int' : FuncUnfold zap.Int' [] zap.field2.impl
  Int32 : FuncUnfold zap.Int32 [] zap.field2.impl
  Int64 : FuncUnfold zap.Int64 [] zap.field2.impl
  Stack : FuncUnfold zap.Stack [] zap.field1.impl
  String : FuncUnfold zap.String [] zap.field2.impl
  Stringer : FuncUnfold zap.Stringer [] zap.field2.impl
  Strings : FuncUnfold zap.Strings [] zap.field2.impl
  Uint : FuncUnfold zap.Uint [] zap.field2.impl
  Uint32 : FuncUnfold zap.Uint32 [] zap.field2.impl
  Uint64 : FuncUnfold zap.Uint64 [] zap.field2.impl
  Write : MethodUnfold (go.GoType.PointerType zap.zapcore.CheckedEntry.ty) go!"Write"
    zapcore.CheckedEntry.Write.impl
  zapcore_init0 : FuncUnfold zap.zapcore.init.«0» [] initNoop

attribute [instance] zap.Bound.NewNop zap.Bound.Debug zap.Bound.Info zap.Bound.Warn
  zap.Bound.Error zap.Bound.Check zap.Bound.Panic zap.Bound.Fatal zap.Bound.Bool'
  zap.Bound.ByteString zap.Bound.Duration zap.Bound.Error' zap.Bound.Int' zap.Bound.Int32
  zap.Bound.Int64 zap.Bound.Stack zap.Bound.String zap.Bound.Stringer zap.Bound.Strings
  zap.Bound.Uint zap.Bound.Uint32 zap.Bound.Uint64 zap.Bound.Write zap.Bound.zapcore_init0

end Model
end EtcdGrove
end Perennial
