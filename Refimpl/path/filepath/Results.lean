/-
`path/filepath`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.path.filepath.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  path_filepath.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
