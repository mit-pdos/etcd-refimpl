/-
`net/url`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.net.url.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  net_url.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
