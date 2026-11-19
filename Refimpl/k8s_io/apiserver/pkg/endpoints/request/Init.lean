/-
`k8s_io/apiserver/pkg/endpoints/request`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/apiserver/pkg/endpoints/request/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.k8s_io.apiserver.pkg.endpoints.request.Init
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

theorem k8s_io_apiserver_pkg_endpoints_request.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.k8s_io.apiserver.pkg.endpoints.request.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.k8s_io.apiserver.pkg.endpoints.request.specialVerbs.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.endpoints.request.specialVerbsNoSubresources.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.endpoints.request.namespaceSubresources.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.endpoints.request.verbsWithSelectors.init := @initNoop,
        _root_.Perennial.k8s_io.apiserver.pkg.endpoints.request.NamespaceSubResourcesForTest.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
