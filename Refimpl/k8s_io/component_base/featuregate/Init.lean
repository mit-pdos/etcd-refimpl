/-
`k8s_io/component_base/featuregate`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/component_base/featuregate/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.k8s_io.component_base.featuregate.Init
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

theorem k8s_io_component_base_featuregate.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.component_base.featuregate.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.k8s_io.component_base.featuregate.defaultFeatures.init := @initNoop,
        _root_.Perennial.k8s_io.component_base.featuregate.specialFeatures.init := @initNoop,
        _root_.Perennial.k8s_io.component_base.featuregate.«_».init := @initNoop,
        _root_.Perennial.k8s_io.component_base.featuregate.«_».init := @initNoop,
        _root_.Perennial.k8s_io.component_base.featuregate.«_».init := @initNoop,
        _root_.Perennial.k8s_io.component_base.featuregate.internalPackages.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
