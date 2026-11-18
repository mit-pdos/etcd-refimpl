module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.HistogramVec__WithLabelValues

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
variable [ref : github_com.prometheus.client_golang.prometheus.Refimpl]
variable [package_sem : github_com.prometheus.client_golang.prometheus.Assumptions]

theorem prometheus.HistogramVec.WithLabelValues.model_proof :
    model% (EtcdGrove.prometheus.HistogramVec.WithLabelValues.spec (GF := GF) (hG := hG)) with [] := by
  intro v lvs ls vs dq
  wp_start as ⟨-, %Hok, Hlvs⟩
  wp_auto
  iapply HΦ
  iexists _
  isplitr
  · ipureintro; rfl
  iframe Hlvs
  unfold prometheus.observerSpec
  iintro !> %f %Φ _ HΦ
  dsimp only
  wp_method_call
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
