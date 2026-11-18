/-
A model of `go.opentelemetry.io/otel/trace`'s trust boundary (names-only in etcd-grove's
translation): `trace.SpanFromContext`.

The reference implementation is Go: `go/third_party/otel_trace`, otel/trace v1.47.0 (etcd's pin)
with the body of `SpanFromContext` replaced (marked `// refimpl:`): the no-op span, whatever the
context holds. The no-op span's methods the spec names are otel's own (empty), translated:

```go
func SpanFromContext(ctx context.Context) Span { return noopSpan{} }

func (noopSpan) End(...SpanEndOption)               {}  // otel's
func (noopSpan) RecordError(error, ...EventOption) {}  // otel's
func (noopSpan) AddEvent(string, ...EventOption)   {}  // otel's
```

(otel returns `noopSpanInstance`, a package variable whose value is `noopSpan{}`; its initializer is
untranslated in etcd-grove, so the reference implementation builds the same value in place.) The
spec's predicates (`trace.isSpan`, `trace.spanCtxOk`) are definitions, not opaque: nothing to model.

`trace.WithAttributes`, the package's other function axiom, is not modelled here: the real code
(`return attributeOption(attributes)`) is plainly provable in etcd-grove (README, "Status").
-/
module

public import Spec.go_opentelemetry_io.otel.trace.SpanFromContext
public import Refimpl.Subst
public import Refimpl.Gen.go_opentelemetry_io.otel.trace
