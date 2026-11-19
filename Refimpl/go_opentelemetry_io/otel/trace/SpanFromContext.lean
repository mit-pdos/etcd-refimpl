module

public import Refimpl.go_opentelemetry_io.otel.trace.Impl

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
variable {GF : BundledGFunctors} [hG : HeapGS HasLC.hasLC GF]
variable [sem : go.Semantics]
variable [ref : go_opentelemetry_io.otel.trace.Refimpl]
variable [package_sem : go_opentelemetry_io.otel.trace.Assumptions]

include ref package_sem in
theorem trace.SpanFromContext.model_proof :
    model% (EtcdGrove.trace.SpanFromContext.spec (GF := GF) (hG := hG)) with [] := by
  intro ctx cd
  wp_start as -
  wp_auto
  iapply HΦ
  unfold EtcdGrove.trace.isSpan
  iexists _
  isplitr; · ipureintro; rfl
  isplitr
  · imodintro; iintro %opts
    wp_start
    iapply HΦ; itrivial
  isplitr
  · imodintro; iintro %name %opts
    wp_start
    iapply HΦ; itrivial
  · imodintro; iintro %err %opts
    wp_start
    iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
