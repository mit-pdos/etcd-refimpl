/-
`go_etcd_io/etcd/server/v3/etcdserver/api/membership`'s package-initialization axioms (`opaqueInitsOk`, `errorsNewVarsInit`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/api/membership/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; `errorsNewVarsInit`'s, each a `var X = errors.New(msg)`, are Go's (`errorsNewVarInit`, Perennial's `errors.New`).
-/
module

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

/-- `ErrIDRemoved`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrIDRemoved.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrIDRemoved
    go!"membership: ID removed"

/-- `ErrIDExists`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrIDExists.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrIDExists
    go!"membership: ID exists"

/-- `ErrIDNotFound`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrIDNotFound.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrIDNotFound
    go!"membership: ID not found"

/-- `ErrPeerURLexists`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrPeerURLexists.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrPeerURLexists
    go!"membership: peerURL exists"

/-- `ErrMemberNotLearner`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrMemberNotLearner.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrMemberNotLearner
    go!"membership: can only promote a learner member"

/-- `ErrTooManyLearners`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrTooManyLearners.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrTooManyLearners
    go!"membership: too many learner members in cluster"

theorem go_etcd_io_etcd_server_v3_etcdserver_api_membership.errorsNewVarsInit.model_proof [errors_sem : _root_.Perennial.errors.Assumptions] :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.errorsNewVarsInit (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrIDRemoved.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrIDRemoved.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrIDExists.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrIDExists.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrIDNotFound.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrIDNotFound.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrPeerURLexists.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrPeerURLexists.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrMemberNotLearner.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrMemberNotLearner.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.membership.ErrTooManyLearners.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_membership.ErrTooManyLearners.initModel] := by
  intro init X msg h
  simp only [List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq] at h
  rcases h with ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ <;>
  exact errorsNewVarInit_ok _ _

end proof

end Model
end EtcdGrove
end Perennial
