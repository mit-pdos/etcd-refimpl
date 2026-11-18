/-
A model of `k8s.io/api/apps/v1`'s trust boundary (names-only in etcd-grove's translation, but for
the types, constants and `metav1.Object` accessors).

The reference implementation is Go: `go-k8s/third_party/api/apps/v1`, k8s.io/api 067c983ccbc3 (the
k8s project's pin) with the bodies of the functions the proofs call replaced (each marked
`// refimpl:`):

```go
func Resource(resource string) schema.GroupResource {
	return schema.GroupResource{Group: "apps", Resource: resource}  // GroupName, without SchemeGroupVersion
}
```

The deep copies (`ControllerRevision.DeepCopyObject`, `DaemonSet.DeepCopyObject`) are not modelled: any implementation
is a full deep copy of the object (the spec gives the copy whole, with the original's deep value),
the generated `DeepCopyInto` (see the README).
-/
module

public import Spec.k8s_io.api.apps.v1.Resource
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.api.apps.v1
