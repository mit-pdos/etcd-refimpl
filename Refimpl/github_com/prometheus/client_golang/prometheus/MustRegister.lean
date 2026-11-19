module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Spec.github_com.prometheus.client_golang.prometheus.MustRegister

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

theorem prometheus.MustRegister.model_proof :
    model% (EtcdGrove.prometheus.MustRegister.spec (GF := GF) (hG := hG)) with
      [EtcdGrove.prometheus.collectorName := @prometheus.collectorName,
        EtcdGrove.prometheus.nameFree := @prometheus.nameFree] := by
  intro s dq c n _
  wp_start as ⟨Hs, -⟩
  wp_auto
  iapply HΦ
  iframe Hs

end proof

end Model
end EtcdGrove
end Perennial
