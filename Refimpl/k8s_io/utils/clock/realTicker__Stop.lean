module

public import Refimpl.k8s_io.utils.clock.Impl
public import Spec.k8s_io.utils.clock.realTicker__Stop

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
variable [ref : k8s_io.utils.clock.Refimpl]
variable [package_sem : k8s_io.utils.clock.Assumptions]

theorem clock.realTicker.Stop.model_proof :
    model% (EtcdGrove.clock.realTicker.Stop.spec (GF := GF) (hG := hG)) with [] := by
  intro p
  wp_start as Hok
  unfold EtcdGrove.clock.realTickerOk
  icases Hok with ⟨%t, %ch, %γ, #Hf, #Ht⟩
  wp_auto
  wp_apply time.Ticker.Stop.wp_proof $$ [Ht]
  · iexists ch, γ; iexact Ht
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
