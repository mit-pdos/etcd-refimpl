/-
`go_etcd_io/etcd/api/v3/v3rpc/rpctypes`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/api/v3/v3rpc/rpctypes/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.Init
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

theorem go_etcd_io_etcd_api_v3_v3rpc_rpctypes.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCLeaseNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCLeaseExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCLeaseTTLTooLarge.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCMemberExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCPeerURLExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCMemberNotEnoughStarted.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCMemberBadURLs.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCMemberNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCMemberNotLearner.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCLearnerNotReady.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCTooManyLearners.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCClusterIDMismatch.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCClusterIdMismatch.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRequestTooLarge.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRequestTooManyRequests.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRootUserNotExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRootRoleNotExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCUserAlreadyExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCUserNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRoleAlreadyExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRoleNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRoleEmpty.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCAuthFailed.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCPermissionNotGiven.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCRoleNotGranted.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCPermissionNotGranted.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCAuthNotEnabled.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCInvalidAuthMgmt.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCNotLeader.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCLeaderChanged.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCStopped.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCTimeout.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCTimeoutDueToLeaderFail.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCTimeoutDueToConnectionLost.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCTimeoutWaitAppliedIndex.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCUnhealthy.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCCorrupt.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCBadLeaderTransferee.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCWrongDowngradeVersionFormat.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCInvalidDowngradeTargetVersion.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCClusterVersionUnavailable.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCDowngradeInProcess.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCNoInflightDowngrade.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCCanceled.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrGRPCDeadlineExceeded.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrEmptyKey.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrKeyNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrValueProvided.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrLeaseProvided.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTooManyOps.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrDuplicateKey.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrInvalidSortOption.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrNoSpace.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrLeaseNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrLeaseExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrLeaseTTLTooLarge.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrMemberExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrPeerURLExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrMemberNotEnoughStarted.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrMemberBadURLs.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrMemberNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrMemberNotLearner.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrMemberLearnerNotReady.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTooManyLearners.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRequestTooLarge.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTooManyRequests.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRootUserNotExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRootRoleNotExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrUserAlreadyExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrUserNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRoleAlreadyExist.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRoleNotFound.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRoleEmpty.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrAuthFailed.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrPermissionDenied.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrRoleNotGranted.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrPermissionNotGranted.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrInvalidAuthMgmt.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrClusterIDMismatch.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrClusterIdMismatch.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrNotLeader.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrLeaderChanged.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrNotCapable.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrStopped.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTimeout.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTimeoutDueToLeaderFail.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTimeoutDueToConnectionLost.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrTimeoutWaitAppliedIndex.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrUnhealthy.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrCorrupt.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrBadLeaderTransferee.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrClusterVersionUnavailable.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrWrongDowngradeVersionFormat.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrInvalidDowngradeTargetVersion.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrDowngradeInProcess.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.v3rpc.rpctypes.ErrNoInflightDowngrade.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
