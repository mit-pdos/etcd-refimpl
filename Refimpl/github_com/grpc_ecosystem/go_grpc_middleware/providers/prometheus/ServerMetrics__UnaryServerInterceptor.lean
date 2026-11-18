module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Impl
public import Spec.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.ServerMetrics__UnaryServerInterceptor

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
variable [ref : github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Refimpl]
variable [package_sem : github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Assumptions]

theorem grpc_prometheus.ServerMetrics.UnaryServerInterceptor.model_proof :
    model% (EtcdGrove.grpc_prometheus.ServerMetrics.UnaryServerInterceptor.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.promSrvMetrics := @promSrvMetrics, EtcdGrove.promSrvMetricsOpt := @promSrvMetricsOpt] := by
  intro m
  wp_start as -
  wp_auto
  iapply HΦ
  iintro !> %Q
  unfold srvInterceptorOk
  iintro !> %ci %cd %req %info %h %Ψ HR #Hctx #Hrc #Hinfo #HQ Hk
  iunfold srvInterceptorCall
  wp_auto
  icases Hk with ⟨Hk, -⟩
  iunfold srvHandlerCall at Hk
  ispecialize Hk $$ HR
  wp_bind (App (App (Val #h) _) _)
  iapply (wp_wand (Φ := fun v => iprop(∃ resp err : GoInterface, ⌜v = PairV #resp #err⌝ ∗
    go_etcd_io.etcd.cache.v3.srvErrOk err ∗ True ∗ (True -∗ Ψ v)))) $$ Hk
  iintro %v ⟨%resp, %err, %Hv, -, -, HΨ⟩
  subst Hv
  wp_auto
  iapply HΨ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
