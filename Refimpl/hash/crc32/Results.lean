/-
`hash/crc32`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.hash.crc32.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  hash_crc32.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
