/-
A model of grpc-prometheus's server metrics, the trust boundary of
`github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus` (names-only in etcd-grove's
translation; the predicates are etcd-grove's `Proof/google_golang_org/grpc/InvGrpcServer.lean`).

The reference implementation is Go: `go/third_party/grpc_prom_provider`, v1.1.0 (etcd's pin) with
the bodies of the functions etcd calls replaced (each marked `// refimpl:`): metrics that record
nothing, whose interceptors are transparent:

```go
func NewServerMetrics(opts ...ServerMetricsOption) *ServerMetrics { return &ServerMetrics{} }
func (m *ServerMetrics) InitializeMetrics(server reflection.ServiceInfoProvider) {}
func (m *ServerMetrics) UnaryServerInterceptor(opts ...Option) grpc.UnaryServerInterceptor {
	return func(ctx context.Context, req any, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (any, error) {
		return handler(ctx, req)
	}
}
func (m *ServerMetrics) StreamServerInterceptor(opts ...Option) grpc.StreamServerInterceptor {
	return func(srv any, ss grpc.ServerStream, info *grpc.StreamServerInfo, handler grpc.StreamHandler) error {
		return handler(srv, ss)
	}
}
func WithServerHandlingTimeHistogram(opts ...HistogramOption) ServerMetricsOption {
	return func(o *serverMetricsConfig) {}
}
```

The predicates: `promSrvMetrics := True`, `promSrvMetricsOpt := True`. `NewServerMetrics` is not
proved yet: etcd-grove's translation leaves `ServerMetrics` an axiomatized type (its fields name
prometheus's types, a package its Goose configuration does not import), whose allocation's
instances are `sorry`, so no implementation's `&ServerMetrics{}` can be proved, and an
`unsafe.Pointer` conversion to `*ServerMetrics` is stuck (not a plain type). Translating the type
in etcd-grove (importing prometheus's names) makes it provable.
-/
module

public import Proof.google_golang_org.grpc.InvGrpcServer
public import Proof.google_golang_org.grpc.InvGrpcStream
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.github_com.grpc_ecosystem.go_grpc_middleware.providers.prometheus

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

/-- `promSrvMetrics`: every location. -/
def promSrvMetrics {GF : BundledGFunctors} [GooseExts] (_m : Loc) : IProp GF := iprop(True)

/-- `promSrvMetricsOpt`: every function (the model's options set nothing). -/
def promSrvMetricsOpt [GooseExts] (_o : GoFunc) : Prop := True

end Model
end EtcdGrove
end Perennial
