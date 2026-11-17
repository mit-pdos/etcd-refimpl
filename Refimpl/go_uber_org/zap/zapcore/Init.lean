/-
`zapcore`'s package initialization in the model (`Refimpl/go_uber_org/zap/Impl.lean`): with every
untranslated variable initializer and `init()` the model's `initNoop`, the trust-boundary axioms
`opaqueInitsOk` and `initFuncsOk` (`Proof/go_uber_org/zap/zapcore/Init.lean`) hold.
-/
module

public import Refimpl.go_uber_org.zap.Impl

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI go_uber_org

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [bound : zap.Bound]

theorem zapcore.opaqueInitsOk.model_proof :
    model% (type_of% (go_uber_org.zap.zapcore.opaqueInitsOk (GF := GF) (hG := hG))) with
      [go_uber_org.zap.zapcore.DefaultClock.init := @initNoop,
        go_uber_org.zap.zapcore._sliceEncoderPool.init := @initNoop,
        go_uber_org.zap.zapcore.«_».init := @initNoop,
        go_uber_org.zap.zapcore._cePool.init := @initNoop,
        go_uber_org.zap.zapcore._errArrayElemPool.init := @initNoop,
        go_uber_org.zap.zapcore._jsonPool.init := @initNoop,
        go_uber_org.zap.zapcore.nullLiteralBytes.init := @initNoop,
        go_uber_org.zap.zapcore.errUnmarshalNilLevel.init := @initNoop,
        go_uber_org.zap.zapcore._levelToColor.init := @initNoop,
        go_uber_org.zap.zapcore._unknownLevelColor.init := @initNoop,
        go_uber_org.zap.zapcore._levelToLowercaseColorString.init := @initNoop,
        go_uber_org.zap.zapcore._levelToCapitalColorString.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem zapcore.initFuncsOk.model_proof :
    model% (type_of% (go_uber_org.zap.zapcore.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  obtain rfl : f = go_uber_org.zap.zapcore.init.«0» := by simpa using hf
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
