module

public import Refimpl.k8s_io.utils.trace.Impl

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
variable [ref : k8s_io.utils.trace.Refimpl]
variable [package_sem : k8s_io.utils.trace.Assumptions]

theorem trace.New.model_proof :
    model% (EtcdGrove.trace.New.spec (GF := GF) (hG := hG)) with [] := by
  intro name fields
  wp_start
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
