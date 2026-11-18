/-
A model of klog's trust boundary (`k8s.io/klog/v2`, names-only in etcd-grove's translation).

The reference implementation is Go: `go/third_party/klog`, klog v2.140.0 (the k8s project's pin)
with the bodies of the functions the proofs call replaced (each marked `// refimpl:`): logging that
does nothing.

```go
func Background() Logger                                          { var l Logger; return l }
func V(level Level) Verbose                                       { return Verbose{} }
func (v Verbose) Infof(format string, args ...interface{})       {}
func (v Verbose) InfoS(msg string, keysAndValues ...interface{}) {}
func Warningf(format string, args ...interface{})                {}
func Errorf(format string, args ...interface{})                  {}
func init()                                                       {}  // klog.go's and klog_file.go's
```

klog's specs have no opaque predicate (their argument conditions are definitions over `fmt`); the
untranslated package-variable initializers are the model's `initNoop`.
-/
module

public import Proof.k8s_io.klog.v2.Init
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.klog.v2
