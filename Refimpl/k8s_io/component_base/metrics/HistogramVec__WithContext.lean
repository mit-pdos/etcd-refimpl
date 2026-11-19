module

public import Refimpl.k8s_io.component_base.metrics.Impl

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
variable [ref : k8s_io.component_base.metrics.Refimpl]

theorem kmetrics.HistogramVec.WithContext.model_proof :
    model% (EtcdGrove.kmetrics.HistogramVec.WithContext.spec (GF := GF) (hG := hG)) with [] := by
  intro hv ls ctx
  wp_start
  wp_auto
  iapply HΦ
  unfold EtcdGrove.kmetrics.histCtxOk
  iintro !> %sl %vs %dq !> %Φ ⟨_, Hsl⟩ HΦ
  wp_method_call
  wp_auto
  iapply HΦ
  iframe Hsl
  iintro !> %x !> %Φ _ HΦ
  wp_method_call
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
