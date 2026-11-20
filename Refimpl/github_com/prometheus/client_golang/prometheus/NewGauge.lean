module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.NewGauge

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

theorem prometheus.NewGauge.model_proof :
    model% (EtcdGrove.prometheus.NewGauge.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.prometheus.collectorName := @prometheus.collectorName] := by
  intro o ns sub name help _ _
  wp_start
  wp_auto
  iapply HΦ
  unfold EtcdGrove.prometheus.metric.gaugeSpec
    EtcdGrove.prometheus.metric.gaugeSetSpec prometheus.collectorName
  isplitr
  · isplitr
    · iintro !> !> %Φ _ HΦ
      dsimp only
      wp_method_call
      wp_auto
      iapply HΦ; itrivial
    isplitr
    · iintro !> !> %Φ _ HΦ
      dsimp only
      wp_method_call
      wp_auto
      iapply HΦ; itrivial
    · iintro !> %x !> %Φ _ HΦ
      dsimp only
      wp_method_call
      wp_auto
      iapply HΦ; itrivial
  isplitr
  · iintro !> %x !> %Φ _ HΦ
    dsimp only
    wp_method_call
    wp_auto
    iapply HΦ; itrivial
  · ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
