module

public import Refimpl.k8s_io.utils.trace.Impl
public import Perennial.GeneratedProof.time

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
variable [time_sem : _root_.Perennial.time.Assumptions]

include time_sem in
theorem trace.Trace.LogIfLong.model_proof :
    model% (EtcdGrove.trace.Trace.LogIfLong.spec (GF := GF) (hG := hG)) with [] := by
  intro t d
  wp_start
  wp_auto
  iapply HΦ; itrivial

end proof

end Model
end EtcdGrove
end Perennial
