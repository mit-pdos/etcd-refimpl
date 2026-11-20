module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.NewGaugeFunc

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
variable [ref : github_com.prometheus.client_golang.prometheus.Refimpl]
variable [package_sem : github_com.prometheus.client_golang.prometheus.Assumptions]

theorem prometheus.NewGaugeFunc.model_proof :
    model% (EtcdGrove.prometheus.NewGaugeFunc.spec (GF := GF) (hG := hG)) with [] := by
  intro o ns sub name help f _
  wp_start
  wp_auto
  iapply HΦ
  itrivial

end proof

end Model
end EtcdGrove
end Perennial
