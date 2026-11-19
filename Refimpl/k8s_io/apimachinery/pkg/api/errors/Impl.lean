/-
A model of `k8s.io/apimachinery/pkg/api/errors`' trust boundary (names-only in etcd-grove's
translation, but for `NewTimeoutError`, `NewBadRequest`, `NewResourceExpired`, `NewNotFound`,
`NewAlreadyExists`, `StatusError.Status` and `StatusError.Error`).

The reference implementation is Go: `go-k8s/third_party/apimachinery/pkg/api/errors`,
k8s.io/apimachinery 0b7d352f711c (the k8s project's pin) with the bodies of the functions the proofs
call replaced (each marked `// refimpl:`). The checks read a `*StatusError` only (the real ones also
unwrap, `errors.As`; the specs' `apiErrOk` admits a `*StatusError` or a `.plain` error, which neither
is nor wraps an `APIStatus`); the constructors build the status without its message (which formats
`err`):

```go
func HasStatusCause(err error, name metav1.CauseType) bool {
	se, ok := err.(*StatusError)
	if !ok || se.ErrStatus.Details == nil {
		return false
	}
	for _, cause := range se.ErrStatus.Details.Causes {
		if cause.Type == name {
			return true
		}
	}
	return false
}

func IsTimeout(err error) bool {
	se, ok := err.(*StatusError)
	if !ok {
		return false
	}
	switch se.ErrStatus.Reason {
	case metav1.StatusReasonTimeout:
		return true
	case metav1.StatusReasonUnauthorized:  // and so on: one case each for knownReasons' 18 others
		return false
	}
	return se.ErrStatus.Code == http.StatusGatewayTimeout
}

func NewConflict(qualifiedResource schema.GroupResource, name string, err error) *StatusError {
	return &StatusError{metav1.Status{Status: metav1.StatusFailure, Code: http.StatusConflict,
		Reason: metav1.StatusReasonConflict, Details: &metav1.StatusDetails{
			Group: qualifiedResource.Group, Kind: qualifiedResource.Resource, Name: name}}}
}

func NewInternalError(err error) *StatusError {
	return &StatusError{metav1.Status{Status: metav1.StatusFailure, Code: http.StatusInternalServerError,
		Reason: metav1.StatusReasonInternalError,
		Details: &metav1.StatusDetails{Causes: []metav1.StatusCause{{}}}}}
}
```

The specs have no opaque predicate (`apiErrOk`, `apiErrAt`, `statusDetailsAt` are definitions).
-/
module

public import Proof.k8s_io.apimachinery.pkg.api.errors.View
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.apimachinery.pkg.api.errors
