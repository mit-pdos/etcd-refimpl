/-
A model of grpc's `metadata` trust boundary (`google.golang.org/grpc/metadata`, names-only in
etcd-grove's translation; `incomingOf` is etcd-grove's `Proof/google_golang_org/grpc/metadata/
Incoming.lean`).

The reference implementation is Go: `go/third_party/grpc`, grpc v1.84.0 (etcd's pin) with the
bodies of the functions etcd calls replaced (each marked `// refimpl:`): no context carries
metadata.

```go
func FromIncomingContext(ctx context.Context) (MD, bool) { return nil, false }
func FromOutgoingContext(ctx context.Context) (MD, bool) { return nil, false }
func init()                                              {}
```

The model: `metadata.incomingOf := none` for every context; the untranslated package-variable
initializer is `initNoop`.

`MD.Get` is no longer an axiom: etcd-grove `4fcdd2aa9d` translates grpc's own code
(`md[strings.ToLower(k)]`) and proves it over `strings.ToLower`'s spec. `AppendToOutgoingContext` is
not modelled: no implementation meets it (README, "Findings").
-/
module

public import Proof.google_golang_org.grpc.metadata.Incoming
public import Proof.google_golang_org.grpc.metadata.Init
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.google_golang_org.grpc.metadata

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

/-- `metadata.incomingOf`: no context has incoming metadata. -/
def metadata.incomingOf [GooseExts] (_ctx : GoInterface) :
    Option (GoString → Option (List GoString)) := none

end Model
end EtcdGrove
end Perennial
