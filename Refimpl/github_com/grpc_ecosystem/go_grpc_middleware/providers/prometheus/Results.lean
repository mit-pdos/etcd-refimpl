/-
grpc-prometheus's axioms proved in the model (`#model_check`), and the binding class checked
against etcd-grove's translated bodies.
-/
module

public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Laws
public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.WithServerHandlingTimeHistogram
public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.NewServerMetrics
public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.ServerMetrics__InitializeMetrics
public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.ServerMetrics__UnaryServerInterceptor
public import Refimpl.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.ServerMetrics__StreamServerInterceptor

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  grpc_prometheus.promSrvMetrics_persistent.model_proof
  grpc_prometheus.WithServerHandlingTimeHistogram.model_proof
  grpc_prometheus.NewServerMetrics.model_proof
  grpc_prometheus.ServerMetrics.InitializeMetrics.model_proof
  grpc_prometheus.ServerMetrics.UnaryServerInterceptor.model_proof
  grpc_prometheus.ServerMetrics.StreamServerInterceptor.model_proof

#bound_check github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus.Refimpl

end Model
end EtcdGrove
end Perennial
