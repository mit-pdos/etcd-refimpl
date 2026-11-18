/-
A model of `k8s.io/utils/trace`'s trust boundary (names-only in etcd-grove's translation).

The reference implementation is Go: `go-k8s/third_party/k8s_utils/trace`, k8s.io/utils
v0.0.0-20260626114624-be93311217bd (the k8s project's pin) with the bodies of the functions the
proofs call replaced (each marked `// refimpl:`): a trace that records nothing.

```go
func New(name string, fields ...Field) *Trace       { return nil }
func (t *Trace) LogIfLong(threshold time.Duration) {}
```

(`Trace`'s type is axiomatized in etcd-grove's translation, which imports neither `sync` nor
`klog`: no allocation of one. Go calls a method on a nil pointer: `LogIfLong` never dereferences
its receiver.) The package's specs have no opaque predicate.

The real `LogIfLong` locks `t.lock`: it panics on a nil `t`, which its spec (any `t`, no premise)
admits (README, "Findings").
-/
module

public import Spec.k8s_io.utils.trace.New
public import Spec.k8s_io.utils.trace.Trace__LogIfLong
public import Refimpl.Subst
public import Refimpl.Gen.k8s_io.utils.trace
