/-
`golang_org/x/sys/unix`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.golang_org.x.sys.unix.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  golang_org_x_sys_unix.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
