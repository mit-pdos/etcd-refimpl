/-
A model of grpc's `status` trust boundary (`google.golang.org/grpc/status` and the `*Status` methods
of `google.golang.org/grpc/internal/status`, names-only in etcd-grove's translation; the opaque
functions and predicates are etcd-grove's `Proof/google_golang_org/grpc/status/StatusRO.lean`).

The reference implementation is Go: `go/third_party/grpc`, grpc v1.84.0 (etcd's pin) with the
bodies of the functions etcd calls replaced (each marked `// refimpl:`): every code is `Unknown`.

```go
// status
func Code(err error) codes.Code { return codes.Unknown }
func Errorf(c codes.Code, format string, a ...any) error { return (*status.Error)(nil) }
// internal/status
func (s *Status) Code() codes.Code { return codes.Unknown }
```

(`Errorf`'s error is a nil `*status.Error` in an `error` interface: not a nil interface, and nothing
is allocated, since etcd-grove's translation leaves `internal/status.Error` an axiomatized type.)

The model: `statusCode := Unknown` (2) for every error, and `grpcStatusROP s c := c = Unknown`.

`status.Error` and `status.FromError` are not modelled: no implementation meets them (README,
"Findings"): their posts equate `errDesc`, a fixed Lean function of the error value, with a string
the caller chooses (`msg`, or the `m` that `Error()` returns), for an error at a freshly allocated
location.
-/
module

public import Proof.google_golang_org.grpc.status.StatusRO
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.google_golang_org.grpc.status
public import Refimpl.Gen.google_golang_org.grpc.internal.status

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

/-- `statusCode`: every error's code is `Unknown`. -/
def statusCode [GooseExts] (_err : GoInterface) : w32 := W32 2

/-- `grpcStatusROP`: a status's code is `Unknown`. -/
def grpcStatusROP (_s : Loc) (c : w32) : Prop := c = W32 2

end Model
end EtcdGrove
end Perennial
