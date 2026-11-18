/-
A model of `metav1.LabelSelectorAsSelector` (`k8s.io/apimachinery/pkg/apis/meta/v1`, names-only in
etcd-grove's translation) and of the predicate its spec is written in, `labels.reqsValid`
(`Proof/k8s_io/apimachinery/pkg/apis/meta/v1/SelDefs.lean`: which non-`nil` selectors it accepts).

The reference implementation is Go: `go-k8s/third_party/apimachinery/pkg/apis/meta/v1`,
k8s.io/apimachinery 0b7d352f711c (the k8s project's pin) with the body replaced (marked
`// refimpl:`): it accepts only the empty selector, and rejects every other with an error value that
needs no allocation and no package initialization (the spec takes no `isPkgInit`); the selectors
returned are `labels.Nothing()` and `labels.Everything()` (`Refimpl/k8s_io/apimachinery/pkg/labels`),
whose `Empty` and `Matches` are the real code:

```go
func LabelSelectorAsSelector(ps *LabelSelector) (labels.Selector, error) {
	if ps == nil {
		return labels.Nothing(), nil
	}
	if len(ps.MatchLabels) == 0 && len(ps.MatchExpressions) == 0 {
		return labels.Everything(), nil
	}
	return nil, runtime.NegotiateError{ContentType: "label selector"}
}
```

So `labels.reqsValid S` is: `S` has no `MatchLabels` pair and no `MatchExpressions` requirement. (The
real code accepts more, the four operators over keys and values `labels.NewRequirement` accepts; the
spec leaves which ones to the uninterpreted `reqsValid`, so the satisfiability of the spec does not
depend on it.)
-/
module

public import Spec.k8s_io.apimachinery.pkg.apis.«meta».v1.LabelSelectorAsSelector
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.k8s_io.apimachinery.pkg.labels.Impl
public import Refimpl.Gen.k8s_io.apimachinery.pkg.apis.«meta».v1

@[expose] public section

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

section defs
variable [GooseExts]

/-- `labels.reqsValid`: the selector is empty (no pair, no requirement). -/
def labels.reqsValid (S : EtcdGrove.labels.SelV) : Prop := GMap.size S.ml = 0 ∧ S.reqs = []

end defs

end Model
end EtcdGrove
end Perennial
