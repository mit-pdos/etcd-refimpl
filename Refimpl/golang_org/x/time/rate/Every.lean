module

public import Refimpl.golang_org.x.time.rate.Impl
public import Perennial.GeneratedProof.time
public import Spec.golang_org.x.time.rate.Every

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
variable [time_sem : _root_.Perennial.time.Assumptions]

include time_sem in
theorem rate.Every.model_proof :
    model% (EtcdGrove.rate.Every.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.rate.limiterRaw := @rate.limiterRaw,
        EtcdGrove.rate.reservationRaw := @rate.reservationRaw] := by
  intro d
  wp_start
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
