/-
`go_etcd_io/etcd/server/v3/etcdserver/api/rafthttp`'s package-initialization axioms (`opaqueInitsOk`, `errorsNewVarsInit`, `initFuncsOk`, etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/api/rafthttp/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`; `errorsNewVarsInit`'s, each a `var X = errors.New(msg)`, are Go's (`errorsNewVarInit`, Perennial's `errors.New`); its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp
public import Proof.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.Init
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
variable [ref : _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.Refimpl]

theorem go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.ConnWriteTimeout.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.proberInterval.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.statusMonitoringInterval.init := @initNoop,
        _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.statusErrorInterval.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

/-- `ErrExceedSizeLimit`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.ErrExceedSizeLimit.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.ErrExceedSizeLimit
    go!"rafthttp: error limit exceeded"

/-- `errIncompatibleVersion`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errIncompatibleVersion.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errIncompatibleVersion
    go!"incompatible version"

/-- `ErrClusterIDMismatch`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.ErrClusterIDMismatch.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.ErrClusterIDMismatch
    go!"cluster ID mismatch"

/-- `errStopped`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errStopped.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errStopped
    go!"stopped"

/-- `errMemberRemoved`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errMemberRemoved.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errMemberRemoved
    go!"the member has been permanently removed from the cluster"

/-- `errUnsupportedStreamType`'s initializer in the model. -/
def go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errUnsupportedStreamType.initModel [GooseExts] [GoGlobalContext] : val :=
  errorsNewVarInit _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errUnsupportedStreamType
    go!"unsupported stream type"

theorem go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errorsNewVarsInit.model_proof [errors_sem : _root_.Perennial.errors.Assumptions] :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errorsNewVarsInit (GF := GF) (hG := hG))) with
      [_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.ErrExceedSizeLimit.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.ErrExceedSizeLimit.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errIncompatibleVersion.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errIncompatibleVersion.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.ErrClusterIDMismatch.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.ErrClusterIDMismatch.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errStopped.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errStopped.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errMemberRemoved.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errMemberRemoved.initModel,
       _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.errUnsupportedStreamType.init :=
        @go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.errUnsupportedStreamType.initModel] := by
  intro init X msg h
  simp only [List.mem_cons, List.not_mem_nil, or_false, Prod.mk.injEq] at h
  rcases h with ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩ <;>
  exact errorsNewVarInit_ok _ _

theorem go_etcd_io_etcd_server_v3_etcdserver_api_rafthttp.initFuncsOk.model_proof :
    model% (type_of% (_root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.initFuncsOk (GF := GF) (hG := hG))) with [] := by
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
