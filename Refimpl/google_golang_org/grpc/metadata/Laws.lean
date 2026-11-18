/-
grpc `metadata`'s law axiom (etcd-grove's `Proof/google_golang_org/grpc/metadata/Incoming.lean`),
read in the model.
-/
module

public import Refimpl.google_golang_org.grpc.metadata.Impl

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

theorem metadata.incomingOf_cancelCtx.model_proof :
    model% (type_of% (EtcdGrove.incomingOf_cancelCtx (GF := GF) (hG := hG))) with
      [EtcdGrove.metadata.incomingOf := @metadata.incomingOf] := by
  intro c p
  iintro -
  ipureintro
  rfl

end proof

end Model
end EtcdGrove
end Perennial
