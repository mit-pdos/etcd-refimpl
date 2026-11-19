/-
`go_etcd_io/etcd/server/v3/etcdserver`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.go_etcd_io.etcd.server.v3.etcdserver.Init
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

theorem go_etcd_io_etcd_server_v3_etcdserver.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.«_».init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.learnerPromoteFailed.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.learnerPromoteSucceed.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.currentVersion.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.currentGoVersion.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.fdUsed.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.fdLimit.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.monitorVersionInterval.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.recommendedMaxRequestBytesString.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
