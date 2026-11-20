/-
A model of `go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc`'s trust
boundary (names-only in etcd-grove's translation, which since etcd-grove `9d1d50a846` translates the
types of grpc's `stats`, so a body returning a `stats.Handler` translates).

The reference implementation is Go: `go/third_party/otelgrpc`, otelgrpc v0.71.0 (etcd's pin) with
`NewServerHandler`'s body replaced (marked `// refimpl:`):

```go
func NewServerHandler(_ ...Option) stats.Handler { return nil }
```

No handler: grpc's `StatsHandler` server option ignores a nil one (`server.go`: "ignoring nil
parameter in grpc.StatsHandler ServerOption"), so no call is tagged or recorded. The predicate the
spec gives its result, etcd-grove's opaque `grpcStatsHandlerOk` (`Proof/google_golang_org/grpc/
InvGrpcServer.lean`), is modelled as "the handler is the nil interface" (`grpcStatsHandlerOk`
below): a nil handler adds no value under any context key and lets every call run, and stores no
span, which is all `grpcRunCtx` presumes of it. Its one consumer, grpc's `StatsHandler` axiom, holds
of the real grpc under this model (the nil handler is ignored); that axiom is grpc's, not modelled
here.
-/
module

public import Spec.go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc.NewServerHandler
public import Refimpl.Subst
public import Refimpl.Gen.go_opentelemetry_io.contrib.instrumentation.google_golang_org.grpc.otelgrpc
public import GeneratedProof.google_golang_org.grpc.stats

@[expose] public section

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

/-- The model of `grpcStatsHandlerOk`: the handler is the nil interface (the reference
implementation's `NewServerHandler` returns `nil`). -/
def grpcStatsHandlerOk [GooseExts] (h : GoInterface) : Prop := h = interface.nil

end Model
end EtcdGrove
end Perennial
