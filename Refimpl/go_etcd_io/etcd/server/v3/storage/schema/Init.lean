/-
`go_etcd_io/etcd/server/v3/storage/schema`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/storage/schema/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.go_etcd_io.etcd.server.v3.storage.schema.Init
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

theorem go_etcd_io_etcd_server_v3_storage_schema.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.«_».init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.«_».init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.«_».init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.alarmBucketName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.clusterBucketName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.membersBucketName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.membersRemovedBucketName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.testBucketName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.Alarm.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.Cluster.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.Members.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.MembersRemoved.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.Test.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.MetaConfStateName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.ClusterClusterVersionKeyName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.ClusterDowngradeKeyName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.MetaStorageVersionName.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.emptyStorageVersion.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.storage.schema.schemaChanges.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
