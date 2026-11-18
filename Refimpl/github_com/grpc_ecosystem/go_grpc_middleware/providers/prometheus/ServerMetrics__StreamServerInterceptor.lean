module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Impl
public import Spec.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.ServerMetrics__StreamServerInterceptor

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

theorem grpc_prometheus.ServerMetrics.StreamServerInterceptor.model_proof :
    model% (EtcdGrove.grpc_prometheus.ServerMetrics.StreamServerInterceptor.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.promSrvMetrics := @promSrvMetrics, EtcdGrove.promSrvMetricsOpt := @promSrvMetricsOpt] := by
  intro m
  wp_start as -
  wp_auto
  iapply HΦ
  unfold srvStreamInterceptorOk
  iintro !> %Req %Rep %hReq %hRep %Up %Dn %γ %ci %cd %srv %st %info %h %Ψ HR Hst #Hinfo Hk
  iunfold streamInterceptorCall
  wp_auto
  icases Hk with ⟨Hk, -⟩
  ispecialize Hk $$ %st %cd Hst
  iunfold streamHandlerCall at Hk
  wp_bind (App (App (Val #h) _) _)
  iapply (wp_wand (Φ := fun v => iprop(∃ err : GoInterface, ⌜v = #err⌝ ∗
    go_etcd_io.etcd.cache.v3.srvErrOk err ∗ (True -∗ Ψ v)))) $$ Hk
  iintro %v ⟨%err, %Hv, -, HΨ⟩
  subst Hv
  wp_auto
  iapply HΨ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
