module

public import Refimpl.k8s_io.utils.clock.Impl
public import Spec.k8s_io.utils.clock.RealClock__Now

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
variable [ref : k8s_io.utils.clock.Refimpl]
variable [package_sem : k8s_io.utils.clock.Assumptions]

theorem clock.RealClock.Now.model_proof :
    model% (EtcdGrove.clock.RealClock.Now.spec (GF := GF) (hG := hG)) with [] := by
  intro c
  wp_start
  wp_auto
  wp_apply time.Now.wp_proof as %t -
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
