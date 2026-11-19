/-
apimachinery `meta/v1`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/k8s_io/apimachinery/pkg/apis/meta/v1/Init.lean`), read in the model: the untranslated package-variable
initializers are `initNoop`, and its `init()`s are Go (empty: they register nothing in the package's scheme).
-/
module

public import Refimpl.Gen.k8s_io.apimachinery.pkg.apis.«meta».v1
public import Proof.k8s_io.apimachinery.pkg.apis.«meta».v1.Init
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
variable [ref : k8s_io.apimachinery.pkg.apis.«meta».v1.Refimpl]

theorem metav1.opaqueInitsOk.model_proof :
    model% (type_of% (k8s_io.apimachinery.pkg.apis.«meta».v1.opaqueInitsOk (GF := GF) (hG := hG))) with
      [k8s_io.apimachinery.pkg.apis.«meta».v1.ErrInvalidLengthGenerated.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.ErrIntOverflowGenerated.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.ErrUnexpectedEndOfGroupGenerated.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.«_».init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.cborNull.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.localSchemeBuilder.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.SchemeGroupVersion.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.Unversioned.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.scheme.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.ParameterCodec.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.optionsTypes.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_APIGroup.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_APIGroupList.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_APIResource.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_APIResourceList.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_APIVersions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ApplyOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_Condition.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_CreateOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_DeleteOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_FieldSelectorRequirement.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_GetOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_GroupVersionForDiscovery.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_LabelSelector.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_LabelSelectorRequirement.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_List.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ListMeta.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ListOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ManagedFieldsEntry.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ObjectMeta.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_OwnerReference.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_PartialObjectMetadata.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_PartialObjectMetadataList.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_Patch.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_PatchOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_Preconditions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_RootPaths.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ServerAddressByClientCIDR.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_ShardInfo.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_Status.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_StatusCause.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_StatusDetails.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_Table.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_TableColumnDefinition.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_TableOptions.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_TableRow.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_TableRowCondition.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_TypeMeta.init := @initNoop,
        k8s_io.apimachinery.pkg.apis.«meta».v1.map_UpdateOptions.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem metav1.initFuncsOk.model_proof :
    model% (type_of% (k8s_io.apimachinery.pkg.apis.«meta».v1.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl | rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
