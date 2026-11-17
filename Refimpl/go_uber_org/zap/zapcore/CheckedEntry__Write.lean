/-
`zapcore.CheckedEntry.Write` in the model (`Refimpl/go_uber_org/zap/Impl.lean`): the reference implementation meets
its spec (`Spec/go_uber_org/zap/zapcore/CheckedEntry__Write.lean`).
-/
module

public import Refimpl.go_uber_org.zap.Impl
public import Spec.go_uber_org.zap.zapcore.CheckedEntry__Write

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

theorem zapcore.CheckedEntry.Write.model_proof :
    model% (EtcdGrove.zapcore.CheckedEntry.Write.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.zap.loggerRaw := @zap.loggerRaw, EtcdGrove.zapcore.zapEntry := @zapcore.zapEntry] := by
  intro ce fields
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
