/-
klog's package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/k8s_io/klog/v2/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`, and its two `init()`s are Go (empty).
-/
module

public import Refimpl.k8s_io.klog.v2.Impl

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
variable [ref : k8s_io.klog.v2.Refimpl]

theorem klog.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.klog.v2.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.klog.v2.klogLogger.init := @initNoop,
        k8s_io.klog.v2.ExitFlushTimeout.init := @initNoop,
        k8s_io.klog.v2.OsExit.init := @initNoop,
        k8s_io.klog.v2.«_».init := @initNoop,
        k8s_io.klog.v2.New.init := @initNoop,
        k8s_io.klog.v2.nilToken.init := @initNoop,
        k8s_io.klog.v2.severityStats.init := @initNoop,
        k8s_io.klog.v2.errVmoduleSyntax.init := @initNoop,
        k8s_io.klog.v2.errTraceSyntax.init := @initNoop,
        k8s_io.klog.v2.timeNow.init := @initNoop,
        k8s_io.klog.v2.MaxSize.init := @initNoop,
        k8s_io.klog.v2.pid.init := @initNoop,
        k8s_io.klog.v2.program.init := @initNoop,
        k8s_io.klog.v2.host.init := @initNoop,
        k8s_io.klog.v2.userName.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem klog.initFuncsOk.model_proof :
    model% (type_of% (k8s_io.klog.v2.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl | rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
