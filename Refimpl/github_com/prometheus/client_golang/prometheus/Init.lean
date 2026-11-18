/-
prometheus's package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/github_com/prometheus/client_golang/prometheus/Init.lean`), read in the model: the
untranslated package-variable initializers are `initNoop`, and its `init()` (`registry.go`'s, which
registers the process and Go collectors in the real code) is Go (empty).
-/
module

public import Refimpl.github_com.prometheus.client_golang.prometheus.Impl
public import Proof.github_com.prometheus.client_golang.prometheus.Init

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

theorem prometheus.opaqueInitsOk.model_proof :
    model% (type_of% (github_com.prometheus.client_golang.prometheus.opaqueInitsOk (GF := GF) (hG := hG))) with
      [github_com.prometheus.client_golang.prometheus.rmNamesForMemStatsMetrics.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.nativeHistogramBounds.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.DefBuckets.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.errBucketLabelNotAllowed.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.errInconsistentCardinality.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.separatorByteSlice.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.defaultRegistry.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.DefaultRegisterer.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.DefaultGatherer.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.«_».init := @initNoop,
        github_com.prometheus.client_golang.prometheus.errQuantileLabelNotAllowed.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.CounterMetricTypePtr.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.GaugeMetricTypePtr.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.UntypedMetricTypePtr.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.labelsPool.init := @initNoop,
        github_com.prometheus.client_golang.prometheus.V2.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem prometheus.initFuncsOk.model_proof :
    model% (type_of% (github_com.prometheus.client_golang.prometheus.initFuncsOk (GF := GF) (hG := hG))) with [] := by
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
