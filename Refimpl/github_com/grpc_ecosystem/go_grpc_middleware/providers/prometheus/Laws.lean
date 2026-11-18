module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Impl

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

theorem grpc_prometheus.promSrvMetrics_persistent.model_proof :
    model% (type_of% (EtcdGrove.promSrvMetrics_persistent (GF := GF))) with
      [EtcdGrove.promSrvMetrics := @promSrvMetrics, EtcdGrove.promSrvMetricsOpt := @promSrvMetricsOpt] := by
  intro m; unfold promSrvMetrics; infer_instance

end proof

end Model
end EtcdGrove
end Perennial
