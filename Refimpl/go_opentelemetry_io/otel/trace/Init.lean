/-
otel `trace`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_opentelemetry_io/otel/trace/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.go_opentelemetry_io.otel.trace.Init
public import Refimpl.Subst
public import Refimpl.Common

@[expose] public section

set_option linter.unusedSectionVars false

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

open Iris Iris.BI

section proof
variable [GooseExts] [GooseSemantics] [GooseInterp]
variable [go_gctx : GoGlobalContext]
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]
variable [sem : go.Semantics]

theorem trace.opaqueInitsOk.model_proof :
    model% (type_of% (go_opentelemetry_io.otel.trace.opaqueInitsOk (GF := GF) (hG := hG))) with
      [go_opentelemetry_io.otel.trace.tracerProviderInstance.init := @initNoop,
        go_opentelemetry_io.otel.trace.«_».init := @initNoop,
        go_opentelemetry_io.otel.trace.start.init := @initNoop,
        go_opentelemetry_io.otel.trace.ended.init := @initNoop,
        go_opentelemetry_io.otel.trace.maxSpan.init := @initNoop,
        go_opentelemetry_io.otel.trace.noopSpanInstance.init := @initNoop,
        go_opentelemetry_io.otel.trace.autoInstEnabled.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
