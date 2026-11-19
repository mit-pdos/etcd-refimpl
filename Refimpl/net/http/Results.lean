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
  net_http.initFuncsOk.model_proof

#bound_check _root_.Perennial.net.http.Refimpl

end Model
end EtcdGrove
end Perennial
