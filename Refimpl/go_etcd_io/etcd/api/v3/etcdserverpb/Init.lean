/-
`go_etcd_io/etcd/api/v3/etcdserverpb`'s package-initialization axioms (`opaqueInitsOk`, `initFuncsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/api/v3/etcdserverpb/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.api.v3.etcdserverpb
public import Proof.go_etcd_io.etcd.api.v3.etcdserverpb.Init
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
variable [ref : _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.Refimpl]

theorem go_etcd_io_etcd_api_v3_etcdserverpb.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_etcdserver_proto_msgTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_etcdserver_proto_goTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_etcdserver_proto_depIdxs.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_raft_internal_proto_msgTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_raft_internal_proto_goTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_raft_internal_proto_depIdxs.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.AlarmType_name.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.AlarmType_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.RangeRequest_SortOrder_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.RangeRequest_SortTarget_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.Compare_CompareResult_name.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.Compare_CompareResult_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.Compare_CompareTarget_name.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.Compare_CompareTarget_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.WatchCreateRequest_FilterType_name.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.WatchCreateRequest_FilterType_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.AlarmRequest_AlarmAction_name.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.AlarmRequest_AlarmAction_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.DowngradeRequest_DowngradeAction_name.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.DowngradeRequest_DowngradeAction_value.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_rpc_proto_enumTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_rpc_proto_msgTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_rpc_proto_goTypes.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.file_rpc_proto_depIdxs.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

theorem go_etcd_io_etcd_api_v3_etcdserverpb.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.api.v3.etcdserverpb.initFuncsOk (GF := GF) (hG := hG))) with [] := by
  intro f hf
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hf
  rcases hf with rfl | rfl | rfl <;>
  · wp_start
    iapply HΦ
    ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
