/-
`golang_org/x/crypto/bcrypt`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.golang_org.x.crypto.bcrypt.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  golang_org_x_crypto_bcrypt.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
