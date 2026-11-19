/-
`golang_org/x/sys/unix`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/golang_org/x/sys/unix/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.golang_org.x.sys.unix.Init
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

theorem golang_org_x_sys_unix.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.golang_org.x.sys.unix.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.golang_org.x.sys.unix.fcntl64Syscall.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.Stdin.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.Stdout.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.Stderr.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.errEAGAIN.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.errEINVAL.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.errENOENT.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.mapper.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.socketProtocol.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.errorList.init := @initNoop,
        _root_.Perennial.golang_org.x.sys.unix.signalList.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
