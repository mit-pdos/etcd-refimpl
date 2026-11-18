/-
`zap.Logger.Fatal` in the model (`Refimpl/go_uber_org/zap/Impl.lean`): the reference implementation meets
its spec (`Spec/go_uber_org/zap/Logger__Fatal.lean`).
-/
module

public import Refimpl.go_uber_org.zap.Impl
public import Spec.go_uber_org.zap.Logger__Fatal

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
variable [ref : go_uber_org.zap.Refimpl] [refc : go_uber_org.zap.zapcore.Refimpl]
variable [package_sem : go_uber_org.zap.Assumptions]

theorem zap.Logger.Fatal.model_proof :
    model% (EtcdGrove.zap.Logger.Fatal.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.zap.loggerRaw := @zap.loggerRaw, EtcdGrove.zapcore.zapEntry := @zapcore.zapEntry] := by
  intro l msg fields
  wp_start
  wp_auto
  wp_for
  wp_for_post
  iframe

end proof

end Model
end EtcdGrove
end Perennial
