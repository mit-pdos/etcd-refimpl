module

public import Refimpl.golang_org.x.time.rate.Impl
public import Spec.golang_org.x.time.rate.NewLimiter

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : golang_org.x.time.rate.Refimpl]
variable [package_sem : golang_org.x.time.rate.Assumptions]

theorem rate.NewLimiter.model_proof :
    model% (EtcdGrove.rate.NewLimiter.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.rate.limiterRaw := @rate.limiterRaw,
        EtcdGrove.rate.reservationRaw := @rate.reservationRaw] := by
  intro r b
  wp_start
  wp_auto
  iapply HΦ
  unfold rate.limiterRaw
  imodintro; itrivial

end proof

end Model
end EtcdGrove
end Perennial
