/-
`k8s_io/apimachinery/pkg/util/errors`'s initialization axioms proved in the model (`#model_check`).
-/
module

public import Refimpl.k8s_io.apimachinery.pkg.util.errors.Init

@[expose] public section

namespace Perennial
namespace EtcdGrove
namespace Model

#model_check
  k8s_io_apimachinery_pkg_util_errors.opaqueInitsOk.model_proof

end Model
end EtcdGrove
end Perennial
