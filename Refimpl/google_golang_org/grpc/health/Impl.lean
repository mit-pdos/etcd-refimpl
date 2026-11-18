/-
A model of grpc's `health` trust boundary (`google.golang.org/grpc/health` and
`google.golang.org/grpc/health/grpc_health_v1`, names-only in etcd-grove's translation;
`grpcHealthSrv` is etcd-grove's `Proof/google_golang_org/grpc/InvGrpcServer.lean`).

The reference implementation is Go: `go/third_party/grpc`, grpc v1.84.0 (etcd's pin) with the
bodies of the functions etcd calls replaced (each marked `// refimpl:`): a health server that
records nothing.

```go
// health
func NewServer() *Server                                                         { return &Server{} }
func (*Server) SetServingStatus(string, healthpb.HealthCheckResponse_ServingStatus) {}
func init()                                                                      {}  // client.go's and producer.go's
// grpc_health_v1
func (HealthCheckResponse_ServingStatus) String() string { return "" }
func init()                                              {}
```

The parameters `SetServingStatus` and `String` ignore are unnamed: their specs take the serving
status as any `val`, and Goose stores a named parameter in a typed variable, which is stuck on a
`val` that is not an `int32` (README, "Findings").

The model: `grpcHealthSrv := True`; the untranslated package-variable initializers are `initNoop`.

Not modelled: `NewServer` (etcd-grove's translation leaves `health.Server` an axiomatized type, so
no implementation's `&Server{}` can be proved), and `RegisterHealthServer` (its spec changes the
server's `grpcSrvNew`, an opaque predicate of grpc's server, which only `Server.RegisterService`'s
axiom gives; grpc's own body, a call to it, is provable in etcd-grove).
-/
module

public import Proof.google_golang_org.grpc.InvGrpcServer
public import Proof.google_golang_org.grpc.health.Init
public import Proof.google_golang_org.grpc.health.grpc_health_v1.Init
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.google_golang_org.grpc.health
public import Refimpl.Gen.google_golang_org.grpc.health.grpc_health_v1

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

/-- `grpcHealthSrv`: every location. -/
def grpcHealthSrv {GF : BundledGFunctors} [GooseExts] (_hs : Loc) : IProp GF := iprop(True)

end Model
end EtcdGrove
end Perennial
