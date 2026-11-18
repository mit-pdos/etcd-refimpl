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

`MD.Get` is not modelled: grpc's own code (`md[strings.ToLower(k)]`) is provable over etcd-grove's
`strings.ToLower` spec, so the proof belongs in etcd-grove. `AppendToOutgoingContext` is not
either: no implementation meets it (README, "Findings").
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
