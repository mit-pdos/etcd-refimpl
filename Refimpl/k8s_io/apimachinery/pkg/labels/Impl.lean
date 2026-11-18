/-
A model of `k8s.io/apimachinery/pkg/labels`' trust boundary (names-only in etcd-grove's translation,
but for `Set.Get` and `Set.Has`).

The reference implementation is Go: `go-k8s/third_party/apimachinery/pkg/labels`, k8s.io/apimachinery
0b7d352f711c (the k8s project's pin) with the bodies of the functions the proofs call replaced
(each marked `// refimpl:`): the shared selectors' values without their package variables (the specs
take no `isPkgInit`), and `MatchesNothing`'s comparison with `sharedNothingSelector`, a
`nothingSelector{}`, as a type assertion (every `nothingSelector` is equal to it):

```go
func Everything() Selector { return internalSelector(nil) }
func Nothing() Selector    { return nothingSelector{} }
func MatchesNothing(selector Selector) bool {
	_, ok := selector.(nothingSelector)
	return ok
}
```

The selectors' `Empty` and `Matches` (`internalSelector`'s, `nothingSelector`'s), which the specs
call (`Everything`'s, and `metav1.LabelSelectorAsSelector`'s `selOk`), are the real code, translated
with its bodies. The specs have no opaque predicate.
-/
module

public import Spec.k8s_io.apimachinery.pkg.labels.Everything
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.apimachinery.pkg.labels

@[expose] public section

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

section lemmas
variable [GooseExts] [GoGlobalContext]

/-- The two selector types differ (`MatchesNothing` tells them apart). -/
theorem labels.internalSelector_ne_nothingSelector :
    k8s_io.apimachinery.pkg.labels.internalSelector.ty ≠
      k8s_io.apimachinery.pkg.labels.nothingSelector.ty := by
  unfold k8s_io.apimachinery.pkg.labels.internalSelector.ty
    k8s_io.apimachinery.pkg.labels.nothingSelector.ty
  simp

end lemmas

end Model
end EtcdGrove
end Perennial
