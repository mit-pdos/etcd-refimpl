/-
A model of `github.com/xiang90/probing`'s trust boundary (names-only in etcd-grove's translation).

The reference implementation is Go: `go/third_party/probing`, probing v0.0.0-20221125231312-a49e3df8f510
(etcd's pin) with the bodies of the functions the proofs call replaced (each marked `// refimpl:`):

```go
func NewHandler() http.Handler { return &httpHealth{} }  // probing's
func (h *httpHealth) ServeHTTP(w http.ResponseWriter, r *http.Request) { w.WriteHeader(200) }

func NewProber(tr http.RoundTripper) Prober { var p *prober; return p }
func (p *prober) Remove(id string) error    { return nil }
func (p *prober) RemoveAll()                {}
```

The handler answers every request with an empty `200` response (probing's writes the time as JSON
too). The prober is a nil `*prober` (`prober`'s type is axiomatized in etcd-grove's translation,
which imports neither `sync` nor `net/http`; Go calls a method on a nil pointer, and the two etcd
calls never dereference it). The specs have no opaque predicate of probing's.

`NewHandler`'s model proof takes net/http's own boundary spec of `ResponseWriter.WriteHeader`
(`http.respWriteHeader_spec`, an axiom of etcd-grove's `Proof/net/http/Axioms.lean`) as a
hypothesis: a handler's response writer (`http.respWriter`) is net/http's opaque predicate, which
only net/http's specs produce, and the spec asks the handler to commit a response. So that model
proof shows probing's axiom satisfiable relative to net/http's.
-/
module

public import Spec.github_com.xiang90.probing.NewHandler
public import Spec.github_com.xiang90.probing.NewProber
public import Refimpl.Subst
public import Refimpl.Gen.github_com.xiang90.probing
