module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Impl
public import Spec.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.ServerMetrics__InitializeMetrics

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

theorem grpc_prometheus.ServerMetrics.InitializeMetrics.model_proof :
    model% (EtcdGrove.grpc_prometheus.ServerMetrics.InitializeMetrics.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.promSrvMetrics := @promSrvMetrics, EtcdGrove.promSrvMetricsOpt := @promSrvMetricsOpt] := by
  intro m gs ics sics svcs regs sregs
  wp_start as ⟨-, Hs⟩
  wp_auto
  iapply HΦ; iexact Hs

end proof

end Model
end EtcdGrove
end Perennial
