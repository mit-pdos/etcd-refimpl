/-
`zap`'s package initialization in the model (`Refimpl/go_uber_org/zap/Impl.lean`): with every
untranslated variable initializer the model's `initNoop`, the trust-boundary axiom `opaqueInitsOk`
(`Proof/go_uber_org/zap/Init.lean`) holds.
-/
module

public import Refimpl.go_uber_org.zap.Impl
public import Proof.go_uber_org.zap.Init

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

theorem zap.opaqueInitsOk.model_proof :
    model% (type_of% (go_uber_org.zap.opaqueInitsOk (GF := GF) (hG := hG))) with
      [go_uber_org.zap.errNoEncoderNameSpecified.init := @initNoop,
        go_uber_org.zap._encoderNameToConstructor.init := @initNoop,
        go_uber_org.zap._errArrayElemPool.init := @initNoop,
        go_uber_org.zap._minTimeInt64.init := @initNoop,
        go_uber_org.zap._maxTimeInt64.init := @initNoop,
        go_uber_org.zap._globalL.init := @initNoop,
        go_uber_org.zap._globalS.init := @initNoop,
        go_uber_org.zap.«_».init := @initNoop,
        go_uber_org.zap._sinkRegistry.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
