module

public import Refimpl.golang_org.x.time.rate.Impl
public import Perennial.GeneratedProof.context
public import Spec.golang_org.x.time.rate.Limiter__Wait

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
variable [context_sem : _root_.Perennial.context.Assumptions]

include context_sem in
theorem rate.Limiter.Wait.model_proof :
    model% (EtcdGrove.rate.Limiter.Wait.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.rate.limiterRaw := @rate.limiterRaw,
        EtcdGrove.rate.reservationRaw := @rate.reservationRaw] := by
  intro rl c cd
  wp_start as -
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
