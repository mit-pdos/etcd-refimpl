/-
`go_etcd_io/etcd/server/v3/etcdserver/api/membership`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`; its `errors.New` variables are translated and proved in etcd-grove since `f61c5c06cc`; etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/api/membership/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.server.v3.etcdserver.api.membership
public import Proof.go_etcd_io.etcd.server.v3.etcdserver.api.membership.Init
public import Refimpl.Subst
public import Refimpl.Common
public import Refimpl.ErrorsNewVar

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
variable [ref : _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.Refimpl]

theorem go_etcd_io_etcd_server_v3_etcdserver_api_membership.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.knownPeers.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.isLearner.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.StoreMembersPrefix.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.storeRemovedMembersPrefix.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem go_etcd_io_etcd_server_v3_etcdserver_api_membership.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.initFuncsOk (GF := GF) (hG := hG))) with [] := by
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
