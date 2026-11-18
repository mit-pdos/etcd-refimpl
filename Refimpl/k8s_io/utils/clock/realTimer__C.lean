module

public import Refimpl.k8s_io.utils.clock.Impl
public import Spec.k8s_io.utils.clock.realTimer__C

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

theorem clock.realTimer.C.model_proof :
    model% (EtcdGrove.clock.realTimer.C.spec (GF := GF) (hG := hG)) with [] := by
  intro p
  wp_start as Hok
  unfold EtcdGrove.clock.realTimerOk
  icases Hok with ⟨%t, %ch, %γ, #Hf, #Ht⟩
  unfold time.isTimer
  icases Ht with ⟨#HC, -, -, #Hbag⟩
  wp_auto
  iapply HΦ
  iexact Hbag

end proof

end Model
end EtcdGrove
end Perennial
