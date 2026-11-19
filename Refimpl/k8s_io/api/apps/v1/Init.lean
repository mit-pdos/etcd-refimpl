/-
`k8s.io/api/apps/v1`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/k8s_io/api/apps/v1/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`.
-/
module

public import Proof.k8s_io.api.apps.v1.Init
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

theorem appsv1.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.api.apps.v1.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.api.apps.v1.ErrInvalidLengthGenerated.init := @initNoop,
        k8s_io.api.apps.v1.ErrIntOverflowGenerated.init := @initNoop,
        k8s_io.api.apps.v1.ErrUnexpectedEndOfGroupGenerated.init := @initNoop,
        k8s_io.api.apps.v1.SchemeGroupVersion.init := @initNoop,
        k8s_io.api.apps.v1.SchemeBuilder.init := @initNoop,
        k8s_io.api.apps.v1.localSchemeBuilder.init := @initNoop,
        k8s_io.api.apps.v1.AddToScheme.init := @initNoop,
        k8s_io.api.apps.v1.map_ControllerRevision.init := @initNoop,
        k8s_io.api.apps.v1.map_ControllerRevisionList.init := @initNoop,
        k8s_io.api.apps.v1.map_DaemonSet.init := @initNoop,
        k8s_io.api.apps.v1.map_DaemonSetCondition.init := @initNoop,
        k8s_io.api.apps.v1.map_DaemonSetList.init := @initNoop,
        k8s_io.api.apps.v1.map_DaemonSetSpec.init := @initNoop,
        k8s_io.api.apps.v1.map_DaemonSetStatus.init := @initNoop,
        k8s_io.api.apps.v1.map_DaemonSetUpdateStrategy.init := @initNoop,
        k8s_io.api.apps.v1.map_Deployment.init := @initNoop,
        k8s_io.api.apps.v1.map_DeploymentCondition.init := @initNoop,
        k8s_io.api.apps.v1.map_DeploymentList.init := @initNoop,
        k8s_io.api.apps.v1.map_DeploymentSpec.init := @initNoop,
        k8s_io.api.apps.v1.map_DeploymentStatus.init := @initNoop,
        k8s_io.api.apps.v1.map_DeploymentStrategy.init := @initNoop,
        k8s_io.api.apps.v1.map_ReplicaSet.init := @initNoop,
        k8s_io.api.apps.v1.map_ReplicaSetCondition.init := @initNoop,
        k8s_io.api.apps.v1.map_ReplicaSetList.init := @initNoop,
        k8s_io.api.apps.v1.map_ReplicaSetSpec.init := @initNoop,
        k8s_io.api.apps.v1.map_ReplicaSetStatus.init := @initNoop,
        k8s_io.api.apps.v1.map_RollingUpdateDaemonSet.init := @initNoop,
        k8s_io.api.apps.v1.map_RollingUpdateDeployment.init := @initNoop,
        k8s_io.api.apps.v1.map_RollingUpdateStatefulSetStrategy.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSet.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetCondition.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetList.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetOrdinals.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetPersistentVolumeClaimRetentionPolicy.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetSpec.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetStatus.init := @initNoop,
        k8s_io.api.apps.v1.map_StatefulSetUpdateStrategy.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
