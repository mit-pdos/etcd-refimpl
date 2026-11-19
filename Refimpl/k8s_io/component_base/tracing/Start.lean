module

public import Refimpl.k8s_io.component_base.tracing.Impl
public import Spec.k8s_io.component_base.tracing.Start

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

theorem tracing.Start.model_proof :
    model% (EtcdGrove.tracing.Start.spec (GF := GF) (hG := hG)) with [] := by
  intro ci cd name attrs
  wp_start as ⟨Hok, Herr, Hk8s⟩
  wp_auto
  ihave %hnn := typedPointsto_not_null _ _ _ $$ «$r1»
  iapply HΦ
  iframe Hok Herr Hk8s
  isplitr
  · ipureintro; exact hnn
  · iintro !> H; iexact H

end proof

end Model
end EtcdGrove
end Perennial
