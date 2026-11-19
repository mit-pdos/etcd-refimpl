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

The model: `grpcHealthSrv := True`; the untranslated package-variable initializers are `initNoop`.

None of the four function specs is proved (README, "Findings"):
- `SetServingStatus` and `ServingStatus.String` are met by no implementation: their specs take the
  serving status as any `val`, a panic outcome `PanicV p` included, and an application to `PanicV p`
  unwinds to `PanicV p`, which is not the `RET` the post names. (The Go above leaves the parameters
  unnamed, so that the bodies would hold for every non-panic `val`.)
- `NewServer`: `health.Server` is still an axiomatized type in etcd-grove's translation (its field
  `updates` names `grpc_health_v1.Health_WatchServer`, an alias from another package, which Goose's
  `translate_types` refuses), so `&Server{}` is stuck.
- `RegisterHealthServer`: its spec changes the server's `grpcSrvNew`, an opaque predicate of grpc's
  server, which only `Server.RegisterService`'s axiom gives; grpc's own body, a call to it, is
  provable in etcd-grove.
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
