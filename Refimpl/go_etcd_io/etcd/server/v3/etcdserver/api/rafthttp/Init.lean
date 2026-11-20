/-
`go_etcd_io/etcd/server/v3/etcdserver/api/rafthttp`'s package-initialization axioms (`initFuncsOk`; its `opaqueInitsOk` is gone, every such variable translated in etcd-grove since `101733cb0e`, and its `errorsNewVarsInit` since `1ed1c7f480`, its `errors.New` variables translated and proved; etcd-grove's
`Proof/go_etcd_io/etcd/server/v3/etcdserver/api/rafthttp/Init.lean`), read in the model: its `init()`s are Go, translated, with empty bodies.
-/
module

public import Refimpl.Gen.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp
public import Proof.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.Init
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
variable [ref : _root_.Perennial.go_etcd_io.etcd.server.v3.etcdserver.api.rafthttp.Refimpl]


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
