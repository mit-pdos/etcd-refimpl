module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.NewHistogram

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

/-- The model's histogram keeps no buckets: the slice's points-to, which the spec consumes, is
dropped. -/
theorem prometheus.NewHistogram.model_proof :
    model% (EtcdGrove.prometheus.NewHistogram.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.prometheus.collectorName := @prometheus.collectorName] := by
  intro o ns sub name help s bs dq _ _ _
  wp_start as -
  wp_auto
  iapply HΦ
  unfold go_etcd_io.etcd.server.v3.storage.mvcc.histSpec prometheus.collectorName
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
