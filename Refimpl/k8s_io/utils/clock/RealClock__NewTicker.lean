module

public import Refimpl.k8s_io.utils.clock.Impl
public import Spec.k8s_io.utils.clock.RealClock__NewTicker

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

theorem clock.RealClock.NewTicker.model_proof :
    model% (EtcdGrove.clock.RealClock.NewTicker.spec (GF := GF) (hG := hG)) with [] := by
  intro c d hd
  wp_start
  wp_alloc res as Hres
  wp_auto
  wp_apply time.NewTicker.wp_proof as %t %ch %γ #Ht
  · ipureintro; exact hd
  wp_alloc p as Hp
  icases typedPointsto_split _ _ _ $$ Hp with Hp
  simp only [TypedPointsto.typedPointstoDef]
  icases Hp with ⟨Hf, -⟩
  imod (typedPointsto_dfractional (GF := GF) _ t).dfractional_persist _ $$ Hf with #Hf
  wp_auto
  iapply HΦ
  unfold EtcdGrove.clock.realTickerOk
  iexists t, ch, γ
  iframe #

end proof

end Model
end EtcdGrove
end Perennial
