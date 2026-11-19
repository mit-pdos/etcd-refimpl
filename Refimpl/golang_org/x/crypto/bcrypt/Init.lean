/-
`golang_org/x/crypto/bcrypt`'s package-initialization axioms (`opaqueInitsOk`, etcd-grove's
`Proof/golang_org/x/crypto/bcrypt/Init.lean`), read in the model: the untranslated package-variable initializers are `initNoop`.
-/
module

public import Proof.golang_org.x.crypto.bcrypt.Init
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

theorem golang_org_x_crypto_bcrypt.opaqueInitsOk.model_proof :
    model% (type_of% (_root_.Perennial.golang_org.x.crypto.bcrypt.opaqueInitsOk (GF := GF) (hG := hG))) with
      [_root_.Perennial.golang_org.x.crypto.bcrypt.bcEncoding.init := @initNoop,
        _root_.Perennial.golang_org.x.crypto.bcrypt.ErrMismatchedHashAndPassword.init := @initNoop,
        _root_.Perennial.golang_org.x.crypto.bcrypt.ErrHashTooShort.init := @initNoop,
        _root_.Perennial.golang_org.x.crypto.bcrypt.magicCipherData.init := @initNoop,
        _root_.Perennial.golang_org.x.crypto.bcrypt.ErrPasswordTooLong.init := @initNoop] := by
  intro v hv
  obtain rfl : v = initNoop := by simpa using hv
  wp_start
  iapply HΦ
  ipureintro; trivial

end proof

end Model
end EtcdGrove
end Perennial
