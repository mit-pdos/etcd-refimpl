module

public import Refimpl.k8s_io.component_base.tracing.Impl
public import Spec.k8s_io.component_base.tracing.Span__AddEvent

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
variable [ref : k8s_io.component_base.tracing.Refimpl]
variable [package_sem : k8s_io.component_base.tracing.Assumptions]

theorem tracing.Span.AddEvent.model_proof :
    model% (EtcdGrove.tracing.Span.AddEvent.spec (GF := GF) (hG := hG)) with [] := by
  intro sp name attrs
  wp_start as -
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
