/-
`k8s_io/apimachinery/pkg/api/validate/content`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/apimachinery/pkg/api/validate/content/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.k8s_io.apimachinery.pkg.api.validate.content.Init
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

theorem k8s_io_apimachinery_pkg_api_validate_content.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.dns1123LabelRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.dns1123SubdomainRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.dns1123SubdomainCaselessRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.cIdentifierRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.conditionReasonRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.labelKeyRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.IsQualifiedName.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.labelValueRegexp.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.pathSegmentNameMayNotBe.init := @initNoop,
        _root_.Perennial.k8s_io.apimachinery.pkg.api.validate.content.pathSegmentNameMayNotContain.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
