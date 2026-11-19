/-
A model of component-base's `tracing` trust boundary (`k8s.io/component-base/tracing`, names-only in
etcd-grove's translation but for its types).

The reference implementation is Go: `go-k8s/third_party/component_base/tracing`, component-base at
the k8s project's pin, with the bodies of the functions the proofs call replaced (each marked
`// refimpl:`): tracing that records nothing, as with a noop tracer provider and no `utiltrace` span.

```go
func Start(ctx context.Context, name string, attributes ...attribute.KeyValue) (context.Context, *Span) {
	return ctx, &Span{}
}
func (s *Span) AddEvent(name string, attributes ...attribute.KeyValue) {}
func (s *Span) End(logThreshold time.Duration)                          {}
func SpanFromContext(ctx context.Context) *Span                        { return &Span{} }
```

`tracing`'s specs have no opaque predicate of its own (`Start`'s are the context's), and its
initializer has no trust-boundary axiom.
-/
module

public import Proof.k8s_io.component_base.tracing.Init
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.Gen.k8s_io.component_base.tracing
