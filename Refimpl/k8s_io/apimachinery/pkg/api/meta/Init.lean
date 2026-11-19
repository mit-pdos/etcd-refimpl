/-
`k8s_io/apimachinery/pkg/api/meta`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/apimachinery/pkg/api/meta/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.k8s_io.apimachinery.pkg.api.«meta».Init
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

theorem k8s_io_apimachinery_pkg_api_meta.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».isListCache.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».errExpectFieldItems.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».errExpectSliceItems.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».objectSliceType.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».objectType.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».rawExtensionObjectType.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».errNotList.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».errNotCommon.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».errNotObject.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».RESTScopeNamespace.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».RESTScopeRoot.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.«meta».unpluralizedSuffixes.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
