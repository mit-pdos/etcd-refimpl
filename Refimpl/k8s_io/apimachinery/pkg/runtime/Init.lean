/-
`k8s_io/apimachinery/pkg/runtime`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/apimachinery/pkg/runtime/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.k8s_io.apimachinery.pkg.runtime.Init
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

theorem k8s_io_apimachinery_pkg_runtime.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.apimachinery.pkg.runtime.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.k8s_io.apimachinery.pkg.runtime.AllocatorPool.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.InternalGroupVersioner.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.DisabledGroupVersioner.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.mapStringInterfaceType.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.stringType.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.fieldCache.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.DefaultUnstructuredConverter.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.cborNull.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.cborSelfDescribed.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.ErrInvalidLengthGenerated.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.ErrIntOverflowGenerated.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.ErrUnexpectedEndOfGroupGenerated.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.DefaultFramer.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.«_».init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.runtime.internalPackages.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
