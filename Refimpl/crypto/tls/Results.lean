/-
`crypto/tls`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.crypto.tls.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  crypto_tls.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
