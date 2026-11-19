module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Impl
public import Spec.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.NewServerMetrics

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

theorem grpc_prometheus.NewServerMetrics.model_proof :
    model% (EtcdGrove.grpc_prometheus.NewServerMetrics.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.promSrvMetrics := @promSrvMetrics, EtcdGrove.promSrvMetricsOpt := @promSrvMetricsOpt] := by
  intro sl os
  wp_start as -
  wp_auto
  ihave %hnn := typedPointsto_not_null _ _ _ $$ «$r0»
  iapply HΦ
  isplitr
  · ipureintro; exact hnn
  · iunfold promSrvMetrics; itrivial

end proof

end Model
end EtcdGrove
end Perennial
