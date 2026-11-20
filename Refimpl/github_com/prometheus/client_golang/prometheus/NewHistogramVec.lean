module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.NewHistogramVec

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

theorem prometheus.NewHistogramVec.model_proof :
    model% (EtcdGrove.prometheus.NewHistogramVec.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.prometheus.vecLabels := @prometheus.vecLabels] := by
  intro o ns sub name help bk bs ls s dq dq' _ _ _ _ _
  wp_start as -
  wp_auto
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
