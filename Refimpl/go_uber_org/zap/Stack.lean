/-
`zap.Stack` in the model (`Refimpl/go_uber_org/zap/Impl.lean`): the reference implementation meets
its spec (`Spec/go_uber_org/zap/Stack.lean`).
-/
module

public import Refimpl.go_uber_org.zap.Impl
public import Spec.go_uber_org.zap.Stack

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

theorem zap.Stack.model_proof :
    model% (EtcdGrove.zap.Stack.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.zap.loggerRaw := @zap.loggerRaw, EtcdGrove.zapcore.zapEntry := @zapcore.zapEntry] := by
  intro x
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
