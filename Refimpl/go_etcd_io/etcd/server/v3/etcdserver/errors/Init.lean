/-
`go_etcd_io/etcd/server/v3/etcdserver/errors`'s package-initialization axioms (`errorsNewVarsInit`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/errors/Init.lean`), read in the model: `errorsNewVarsInit`'s, each a `var X = errors.New(msg)`, are Go's (`errorsNewVarInit`, Perennial's `errors.New`).
-/
module

public import Proof.go_etcd_io.etcd.server.v3.etcdserver.errors.Init
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

/-- `ErrUnknownMethod`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrUnknownMethod.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrUnknownMethod
    go!"etcdserver: unknown method"

/-- `ErrStopped`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrStopped.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrStopped
    go!"etcdserver: server stopped"

/-- `ErrCanceled`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrCanceled.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrCanceled
    go!"etcdserver: request cancelled"

/-- `ErrTimeout`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeout.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeout
    go!"etcdserver: request timed out"

/-- `ErrTimeoutDueToLeaderFail`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutDueToLeaderFail.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutDueToLeaderFail
    go!"etcdserver: request timed out, possibly due to previous leader failure"

/-- `ErrTimeoutDueToConnectionLost`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutDueToConnectionLost.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutDueToConnectionLost
    go!"etcdserver: request timed out, possibly due to connection lost"

/-- `ErrTimeoutLeaderTransfer`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutLeaderTransfer.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutLeaderTransfer
    go!"etcdserver: request timed out, leader transfer took too long"

/-- `ErrTimeoutWaitAppliedIndex`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutWaitAppliedIndex.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutWaitAppliedIndex
    go!"etcdserver: request timed out, waiting for the applied index took too long"

/-- `ErrLeaderChanged`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrLeaderChanged.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrLeaderChanged
    go!"etcdserver: leader changed"

/-- `ErrNotEnoughStartedMembers`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNotEnoughStartedMembers.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNotEnoughStartedMembers
    go!"etcdserver: re-configuration failed due to not enough started members"

/-- `ErrLearnerNotReady`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrLearnerNotReady.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrLearnerNotReady
    go!"etcdserver: can only promote a learner member which is in sync with leader"

/-- `ErrNoLeader`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNoLeader.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNoLeader
    go!"etcdserver: no leader"

/-- `ErrNotLeader`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNotLeader.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNotLeader
    go!"etcdserver: not leader"

/-- `ErrRequestTooLarge`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrRequestTooLarge.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrRequestTooLarge
    go!"etcdserver: request is too large"

/-- `ErrNoSpace`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNoSpace.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNoSpace
    go!"etcdserver: no space"

/-- `ErrTooManyRequests`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTooManyRequests.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTooManyRequests
    go!"etcdserver: too many requests"

/-- `ErrUnhealthy`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrUnhealthy.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrUnhealthy
    go!"etcdserver: unhealthy cluster"

/-- `ErrCorrupt`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrCorrupt.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrCorrupt
    go!"etcdserver: corrupt cluster"

/-- `ErrBadLeaderTransferee`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrBadLeaderTransferee.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrBadLeaderTransferee
    go!"etcdserver: bad leader transferee"

/-- `ErrClusterVersionUnavailable`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrClusterVersionUnavailable.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrClusterVersionUnavailable
    go!"etcdserver: cluster version not found during downgrade"

/-- `ErrWrongDowngradeVersionFormat`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrWrongDowngradeVersionFormat.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrWrongDowngradeVersionFormat
    go!"etcdserver: wrong downgrade target version format"

/-- `ErrKeyNotFound`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_errors.ErrKeyNotFound.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrKeyNotFound
    go!"etcdserver: key not found"

theorem go_etcd_io_etcd_server_v3_etcdserver_errors.errorsNewVarsInit.model_proof [errors_sem : _root_.Perennial.errors.Assumptions] :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.errorsNewVarsInit (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrUnknownMethod.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrUnknownMethod.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrStopped.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrStopped.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrCanceled.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrCanceled.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeout.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeout.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutDueToLeaderFail.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutDueToLeaderFail.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutDueToConnectionLost.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutDueToConnectionLost.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutLeaderTransfer.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutLeaderTransfer.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTimeoutWaitAppliedIndex.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTimeoutWaitAppliedIndex.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrLeaderChanged.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrLeaderChanged.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNotEnoughStartedMembers.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNotEnoughStartedMembers.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrLearnerNotReady.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrLearnerNotReady.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNoLeader.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNoLeader.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNotLeader.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNotLeader.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrRequestTooLarge.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrRequestTooLarge.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrNoSpace.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrNoSpace.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrTooManyRequests.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrTooManyRequests.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrUnhealthy.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrUnhealthy.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrCorrupt.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrCorrupt.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrBadLeaderTransferee.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrBadLeaderTransferee.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrClusterVersionUnavailable.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrClusterVersionUnavailable.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrWrongDowngradeVersionFormat.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrWrongDowngradeVersionFormat.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.errors.ErrKeyNotFound.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_errors.ErrKeyNotFound.initModel] := by
  intro init X msg h
  simp only [List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq] at h
  rcases h with ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ <;>
  exact errorsNewVarInit_ok _ _

end proof

end Model
end EtcdGrove
end Perennial
