/-
`zap.NewNop` in the model (`Refimpl/go_uber_org/zap/Impl.lean`): the reference implementation meets
its spec (`Spec/go_uber_org/zap/NewNop.lean`).
-/
module

public import Refimpl.go_uber_org.zap.Impl
public import Spec.go_uber_org.zap.NewNop

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
variable [package_sem : go_uber_org.zap.Assumptions]

theorem zap.NewNop.model_proof :
    model% (EtcdGrove.zap.NewNop.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.zap.loggerRaw := @zap.loggerRaw, EtcdGrove.zapcore.zapEntry := @zapcore.zapEntry] := by
  wp_start
  wp_alloc l as Hl
  icases typedPointsto_not_null_dup _ _ _ $$ Hl with ⟨-, %Hnn⟩
  iapply HΦ
  unfold zap.loggerRaw
  isplit
  · ipureintro; exact Hnn
  · imodintro; ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
