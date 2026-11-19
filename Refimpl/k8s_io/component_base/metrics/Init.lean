/-
component-base `metrics`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/k8s_io/component_base/metrics/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`, and its `init()`s are Go (empty: it records no process start time).
-/
module

public import Refimpl.Gen.k8s_io.component_base.metrics
public import Proof.k8s_io.component_base.metrics.Init
public import Refimpl.Subst
public import Refimpl.Common

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
variable {hlc : HasLC} {GF : BundledGFunctors} [hG : HeapGS hlc GF]
variable [sem : go.Semantics]
variable [ref : k8s_io.component_base.metrics.Refimpl]

theorem kmetrics.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.component_base.metrics.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.component_base.metrics.DefBuckets.init := @initNoop,
        k8s_io.component_base.metrics.«_».init := @initNoop,
        k8s_io.component_base.metrics.noopCounterVec.init := @initNoop,
        k8s_io.component_base.metrics.noopHistogramVec.init := @initNoop,
        k8s_io.component_base.metrics.noopTimingHistogramVec.init := @initNoop,
        k8s_io.component_base.metrics.noopGaugeVec.init := @initNoop,
        k8s_io.component_base.metrics.noop.init := @initNoop,
        k8s_io.component_base.metrics.disabledMetrics.init := @initNoop,
        k8s_io.component_base.metrics.disabledMetricsTotal.init := @initNoop,
        k8s_io.component_base.metrics.hiddenMetricsTotal.init := @initNoop,
        k8s_io.component_base.metrics.cardinalityEnforcementUnexpectedCategorizationsTotal.init := @initNoop,
        k8s_io.component_base.metrics.labelValueAllowLists.init := @initNoop,
        k8s_io.component_base.metrics.defObjectives.init := @initNoop,
        k8s_io.component_base.metrics.processStartTime.init := @initNoop,
        k8s_io.component_base.metrics.registeredMetricsTotal.init := @initNoop,
        k8s_io.component_base.metrics.BuildVersion.init := @initNoop,
        k8s_io.component_base.metrics.buildInfo.init := @initNoop,
        k8s_io.component_base.metrics.versionRe.init := @initNoop,
        k8s_io.component_base.metrics.errNotRegistered.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem kmetrics.initFuncsOk.model_proof :
    model% (type_of% (k8s_io.component_base.metrics.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  subst hf
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
