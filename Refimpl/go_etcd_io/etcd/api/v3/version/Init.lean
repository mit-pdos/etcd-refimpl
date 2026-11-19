/-
`go_etcd_io/etcd/api/v3/version`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/api/v3/version/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.go_etcd_io.etcd.api.v3.version.Init
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

theorem go_etcd_io_etcd_api_v3_version.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.api.v3.version.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.api.v3.version.APIVersion.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.GitSHA.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_0.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_1.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_2.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_3.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_4.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_5.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_7.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_8.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V3_9.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.V4_0.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.version.AllVersions.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
