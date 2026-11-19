/-
`k8s_io/apiserver/pkg/storage/value`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/k8s_io/apiserver/pkg/storage/value/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.k8s_io.apiserver.pkg.storage.value
public import Proof.k8s_io.apiserver.pkg.storage.value.Init
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
variable [ref : _root_.Perennial.k8s_io.apiserver.pkg.storage.value.Refimpl]

theorem k8s_io_apiserver_pkg_storage_value.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.apiserver.pkg.storage.value.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.k8s_io.apiserver.pkg.storage.value.transformerLatencies.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.storage.value.transformerOperationsTotal.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.storage.value.envelopeTransformationCacheMissTotal.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.storage.value.dataKeyGenerationLatencies.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.storage.value.dataKeyGenerationFailuresTotal.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.storage.value.«_».init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem k8s_io_apiserver_pkg_storage_value.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.apiserver.pkg.storage.value.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
