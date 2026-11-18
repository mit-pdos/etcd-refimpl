/-
What the packages' models share.
-/
module

public import Perennial.Golang.Defn

@[expose] public section

noncomputable section

namespace Perennial
namespace EtcdGrove
namespace Model

section code
variable [GooseExts] [GoGlobalContext]

/-- An initializer that does nothing: the model of every untranslated package-variable initializer
`X.init` (a data axiom of etcd-grove's translation), and of zapcore's `init()`. -/
def initNoop : val := LamV BAnon (Val #())

end code

end Model
end EtcdGrove
end Perennial
