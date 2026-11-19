/-
`k8s_io/apiserver/pkg/storage/value`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/apiserver/pkg/storage/value/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

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

end proof

end Model
end EtcdGrove
end Perennial
