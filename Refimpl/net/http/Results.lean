/-
`net/http`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.net.http.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  net_http.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
