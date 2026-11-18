module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Impl
public import Spec.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.WithServerHandlingTimeHistogram

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

theorem grpc_prometheus.WithServerHandlingTimeHistogram.model_proof :
    model% (EtcdGrove.grpc_prometheus.WithServerHandlingTimeHistogram.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.promSrvMetrics := @promSrvMetrics, EtcdGrove.promSrvMetricsOpt := @promSrvMetricsOpt] := by
  wp_start
  wp_auto
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
