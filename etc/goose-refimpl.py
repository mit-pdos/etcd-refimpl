#!/usr/bin/env python3
"""Translate the Go reference implementations (go/) with etcd-grove's pinned Goose, and generate
the Lean modules the model proofs bind them with (Refimpl/Gen/).

A reference implementation of a Go package etcd-grove translates names-only is a copy of that
package's real source at etcd's pinned version (go/third_party/<module>/, replacing it in go/go.mod)
with the bodies of the functions etcd calls replaced by simple Go (each marked `// refimpl:`). Its
Goose configuration (go/goose-config/, the same paths as etcd-grove's Code/**/*.toml) is
etcd-grove's, plus those functions in `translate`.

For each package, this script runs Goose (built from the pinned Perennial) on go/ with the etcd
project's -lean-root arguments, and compares the result with etcd-grove's checked-in translation
of the package (.lake/packages/etcdGrove/Code/<pkg>.lean):

- it must be a pure superset, every line of etcd-grove's file unchanged and in order: the copy
  declares the same types, names and constants, so the reference implementation is a drop-in
  replacement of the package etcd-grove assumes (otherwise the script fails, showing the diff);
- what it adds is the translated bodies (`X.impl`, top-level definitions, kept verbatim) and the
  fields binding them (`X_unfold : FuncUnfold X [] X.impl` in `Assumptions`, `ptr_M_unfold :
  MethodUnfold ... M.impl` in `T.TypeAssumptions`), which become the fields of one class
  `<pkg>.Refimpl`, the hypothesis of the package's model proofs (`#bound_check` checks that no
  translated body of etcd-grove binds the same names).

Refimpl/Gen/<pkg>.lean is generated: never edit it. `--check` exits 1 if it is not what the
translation gives.
"""
import argparse
import difflib
import importlib.util
import os
import re
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GROVE = os.path.join(ROOT, ".lake", "packages", "etcdGrove")
PERENNIAL = os.path.join(ROOT, ".lake", "packages", "perennial")
# The Go module of each etcd-grove Goose project's reference implementations (its go.mod pins the
# dependencies at that project's versions: go-k8s/'s are examples/k8s/etcd3/go.mod's).
GODIRS = {"etcd": os.path.join(ROOT, "go"), "k8s-apiserver": os.path.join(ROOT, "go-k8s")}
BIN = os.path.join(ROOT, ".lake", "goose-bin")
# The reference implementations of standard-library packages: copies of the pinned toolchain's
# files (stdlib/src/<pkg>/<file>.go, the toolchain's own paths), modified. The standard library
# cannot be replaced in a go.mod, so the translation runs with a GOROOT that is the toolchain's
# (symlinked) with these files in place of its own (`patched_goroot`).
STDLIB = os.path.join(ROOT, "stdlib")

# The Go packages with a reference implementation (each is translated, compared and generated),
# with the etcd-grove Goose project that translates the package (whose -lean-root arguments map
# its imports to the same modules as etcd-grove's translation).
PACKAGES = {
    "go.uber.org/zap": "etcd",
    "go.uber.org/zap/zapcore": "etcd",
    "github.com/jonboulle/clockwork": "etcd",
    "golang.org/x/time/rate": "etcd",
    "github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus": "etcd",
    "go.opentelemetry.io/otel/trace": "etcd",
    "github.com/xiang90/probing": "etcd",
    "github.com/prometheus/client_golang/prometheus": "etcd",
    "google.golang.org/grpc/status": "etcd",
    "google.golang.org/grpc/internal/status": "etcd",
    "google.golang.org/grpc/metadata": "etcd",
    "google.golang.org/grpc/health": "etcd",
    "google.golang.org/grpc/health/grpc_health_v1": "etcd",
    "google.golang.org/grpc/codes": "etcd",
    "google.golang.org/grpc": "etcd",
    "google.golang.org/grpc/grpclog": "etcd",
    "go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc": "etcd",
    "k8s.io/klog/v2": "k8s-apiserver",
    "k8s.io/component-base/tracing": "k8s-apiserver",
    "k8s.io/utils/trace": "k8s-apiserver",
    "k8s.io/apimachinery/pkg/api/errors": "k8s-apiserver",
    "k8s.io/apimachinery/pkg/labels": "k8s-apiserver",
    "k8s.io/apimachinery/pkg/apis/meta/v1": "k8s-apiserver",
    "k8s.io/api/core/v1": "k8s-apiserver",
    "k8s.io/api/apps/v1": "k8s-apiserver",
    "k8s.io/apiserver/pkg/storage/etcd3/metrics": "k8s-apiserver",
    "k8s.io/component-base/metrics": "k8s-apiserver",
    "k8s.io/apiserver/pkg/audit": "k8s-apiserver",
    "k8s.io/apiserver/pkg/storage/value": "k8s-apiserver",
    "github.com/Masterminds/semver/v3": "etcd",
    "github.com/dustin/go-humanize": "etcd",
    "go.etcd.io/etcd/api/v3/authpb": "etcd",
    "go.etcd.io/etcd/api/v3/etcdserverpb": "etcd",
    "go.etcd.io/etcd/api/v3/membershippb": "etcd",
    "go.etcd.io/etcd/api/v3/mvccpb": "etcd",
    "go.etcd.io/etcd/api/v3/version": "etcd",
    "go.etcd.io/etcd/client/v3": "etcd",
    "go.etcd.io/etcd/server/v3/auth": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/api": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/api/membership": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/api/rafthttp": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/api/snap": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/api/v3rpc": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/apply": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver": "etcd",
    "go.etcd.io/etcd/server/v3/etcdserver/txn": "etcd",
    "go.etcd.io/etcd/server/v3/lease": "etcd",
    "go.etcd.io/etcd/server/v3/lease/leasepb": "etcd",
    "go.etcd.io/etcd/server/v3/storage/backend": "etcd",
    "go.etcd.io/etcd/server/v3/storage": "etcd",
    "go.etcd.io/etcd/server/v3/storage/mvcc": "etcd",
    "go.etcd.io/etcd/server/v3/storage/schema": "etcd",
    "go.etcd.io/etcd/server/v3/storage/wal": "etcd",
    "go.etcd.io/etcd/server/v3/storage/wal/walpb": "etcd",
    "net/http": "etcd",
    "encoding/json": "k8s-apiserver",
    "internal/bytealg": "etcd",
}

MARK = "-- Generated by etc/goose-refimpl.py from go/: do not edit."


_GROVE_GOOSE = None


def grove_goose():
    """etcd-grove's etc/goose.py, loaded as a module."""
    global _GROVE_GOOSE
    if _GROVE_GOOSE is None:
        spec = importlib.util.spec_from_file_location("grove_goose", os.path.join(GROVE, "etc", "goose.py"))
        g = importlib.util.module_from_spec(spec)
        argv, sys.argv = sys.argv, ["goose.py"]
        try:
            spec.loader.exec_module(g)
        finally:
            sys.argv = argv
        _GROVE_GOOSE = g
    return _GROVE_GOOSE


def lean_roots(project):
    """The -lean-root arguments of etcd-grove's Goose project `project` (its etc/goose.py)."""
    proj = [p for p in grove_goose().PROJECTS if p.name == project][0]
    return [a for r in proj.lean_roots for a in ("-lean-root", r)]


def build_goose():
    os.makedirs(BIN, exist_ok=True)
    # with etcd-grove's toolchain, as its etc/goose.py does: goose type-checks against the standard
    # library it was built with (a go1.26 goose refuses a module that needs go1.27)
    subprocess.run(["go", "build", "-o", BIN + os.sep, "./goose/cmd/goose"], cwd=PERENNIAL, check=True,
                   env=dict(os.environ, GOTOOLCHAIN=grove_goose().GO_TOOLCHAIN))
    return os.path.join(BIN, "goose")


def patched_goroot(tmp):
    """A copy of the pinned toolchain's GOROOT, every file a symbolic link to the toolchain's but the
    files of stdlib/, which are copied in their place; with the environment that makes `go` (and
    goose, through it) use it."""
    env = dict(os.environ, GOTOOLCHAIN=grove_goose().GO_TOOLCHAIN)
    real = subprocess.run(["go", "env", "GOROOT"], env=env, check=True, capture_output=True,
                          text=True).stdout.strip()
    root = os.path.join(tmp, "goroot")
    subprocess.run(["cp", "-as", real, root], check=True)
    for d, _, files in os.walk(STDLIB):
        for f in files:
            rel = os.path.relpath(os.path.join(d, f), STDLIB)
            dst = os.path.join(root, rel)
            if not os.path.lexists(dst):
                sys.exit(f"goose-refimpl: stdlib/{rel} is not a file of the toolchain's GOROOT")
            os.remove(dst)
            shutil.copyfile(os.path.join(d, f), dst)
    return dict(os.environ, GOTOOLCHAIN="local", GOROOT=root,
                PATH=os.path.join(root, "bin") + os.pathsep + os.environ["PATH"])


def pkg_path(pkg):
    """go.uber.org/zap/zapcore -> go_uber_org/zap/zapcore (Goose's file layout)."""
    first, *rest = pkg.split("/")
    return "/".join([first.replace(".", "_").replace("-", "_")] +
                    [r.replace(".", "_").replace("-", "_") for r in rest])


# Lean keywords that are also Go package path components (`k8s.io/apimachinery/pkg/apis/meta/v1`),
# written «...» in module and namespace names, as goose does
KEYWORDS = {"meta", "end", "open", "section", "namespace", "import", "export", "at", "by", "do",
            "fun", "have", "in", "let", "show", "from", "then", "else", "if", "match", "with",
            "where", "instance", "class", "structure", "axiom", "theorem", "def", "example", "module"}


def module_of(path):
    return ".".join(f"«{c}»" if c in KEYWORDS else c for c in path.split("/"))


FIELD = re.compile(r"^  (\S+) : (FuncUnfold|MethodUnfold) (.*)$")


def split_attrs(lines):
    """`attribute [instance] A` (its first entry on the line) as `attribute [instance]` and `  A`, so
    that entries added before the first one are an insertion, not a change of that line."""
    out = []
    for line in lines:
        m = re.match(r"^attribute \[instance\] (\S.*)$", line.rstrip("\n"))
        if m:
            out += ["attribute [instance]\n", "  " + m.group(1) + "\n"]
        else:
            out.append(line)
    return out


def extract(old, new, pkg):
    """The impl definitions and the binding fields `new` adds to `old` (lists of lines)."""
    old, new = split_attrs(old), split_attrs(new)
    sm = difflib.SequenceMatcher(a=old, b=new, autojunk=False)
    defs, fields = [], []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag == "equal":
            continue
        if tag != "insert":
            diff = "".join(difflib.unified_diff(old, new, "etcd-grove", "refimpl"))
            sys.exit(f"goose-refimpl: the translation of {pkg} changes etcd-grove's "
                     f"(line {i1 + 1}: {tag}), not only adds to it:\n{diff[:4000]}")
        # the enclosing top-level construct of the insertion point in `old`
        k = i1 - 1
        while k >= 0 and (old[k].strip() == "" or old[k][0] in " \t"):
            k -= 1
        ctx = old[k] if k >= 0 else ""
        block = new[j1:j2]
        if ctx.startswith("class ") and i1 < len(old) and (old[i1 - 1].startswith("  ") or old[i1 - 1].startswith("class ")):
            owner = ctx.split()[1]
            prefix = "" if owner == "Assumptions" else owner.removesuffix(".TypeAssumptions").replace(".", "_") + "_"
            for line in block:
                m = FIELD.match(line.rstrip("\n"))
                if m:
                    fields.append((prefix + m.group(1), m.group(2) + " " + m.group(3)))
                elif fields and line.strip() and not re.match(r"^  \S+ : ", line):
                    # a field's type continued (a value receiver's method seen through a pointer:
                    # a load and a `MethodResolve`, over several lines)
                    n, t = fields[-1]
                    fields[-1] = (n, t + "\n    " + line.strip())
                else:
                    sys.exit(f"goose-refimpl: {pkg}: an unexpected line added to {owner}: {line!r}")
        elif ctx.startswith("attribute [instance]"):
            for line in block:
                if not re.match(r"^  \S+$", line.rstrip("\n")):
                    sys.exit(f"goose-refimpl: {pkg}: an unexpected line added to an attribute: {line!r}")
        else:
            defs.extend(block)
    return defs, fields


REF = re.compile(r"_root_\.Perennial\.([A-Za-z0-9_.«»]+)")


def body_imports(defs, path):
    """The modules the translated bodies need beyond etcd-grove's names-only file: for each
    `_root_.Perennial.a.b.Name` they mention, the longest prefix `a.b` that is a translated package
    (Perennial's `Perennial/Code/a/b.lean` or etcd-grove's `Code/a/b.lean`)."""
    mods = set()
    for m in REF.finditer("".join(defs)):
        parts = m.group(1).split(".")
        for n in range(len(parts) - 1, 0, -1):
            rel = os.path.join(*[q.strip("«»") for q in parts[:n]]) + ".lean"
            if os.path.exists(os.path.join(PERENNIAL, "Perennial", "Code", rel)):
                mods.add("Perennial.Code." + ".".join(parts[:n]))
                break
            if os.path.exists(os.path.join(GROVE, "Code", rel)):
                mods.add("Code." + ".".join(parts[:n]))
                break
    mods.discard("Code." + module_of(path))
    return sorted(mods)


def translation_files(out, path, pkg):
    """The files of a package's translation, relative to Code/: `<path>.lean`, and the chunks Goose
    splits a large package into (`<path>/chunk<i>.lean`, which the main file imports); the same
    files as etcd-grove's."""
    def chunks(root):
        d = os.path.join(root, path)
        return sorted(os.path.join(path, f) for f in os.listdir(d)
                      if re.fullmatch(r"chunk\d+\.lean", f)) if os.path.isdir(d) else []
    ours, theirs = chunks(out), chunks(os.path.join(GROVE, "Code"))
    if ours != theirs:
        sys.exit(f"goose-refimpl: {pkg}: the translation's chunks {ours} are not etcd-grove's {theirs}")
    return [path + ".lean"] + ours


def generate(pkg, path, defs, fields):
    ns = module_of(path)
    out = [
        MARK + "\n",
        "/- The reference implementation of `" + pkg + "` (go/), as Goose translates it: the bodies of\n",
        "the functions etcd calls, and the class `" + ns + ".Refimpl` binding their names to them,\n",
        "on top of etcd-grove's names-only translation of the package. -/\n",
        "module\n\n",
        f"public import Code.{module_of(path)}\n",
        *[f"public import {m}\n" for m in body_imports(defs, path)],
        "public import Perennial.Golang.Defn\n\n",
        "@[expose] public section\n\n",
        "set_option autoImplicit false\nset_option maxRecDepth 100000\nset_option maxHeartbeats 0\n",
        "set_option linter.all false\n\n",
        "namespace Perennial\nnoncomputable section\n\n",
        f"namespace {ns}\n\n",
    ]
    out += defs
    out += ["\n/-- The reference implementation's bindings: each name to its translated body. -/\n",
            "class Refimpl [GooseExts] [GoGlobalContext] [GoLocalContext] [GoSemanticsFunctions] : Prop where\n"]
    out += [f"  {n} : {t}\n" for n, t in fields]
    out += ["\nattribute [instance]\n"] + [f"  Refimpl.{n}\n" for n, _ in fields]
    out += [f"\nend {ns}\n\nend\nend Perennial\n"]
    return "".join(out)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--check", action="store_true", help="exit 1 if Refimpl/Gen/ is not up to date")
    args = ap.parse_args()
    goose = build_goose()
    tmp = tempfile.mkdtemp(prefix="goose-refimpl-")
    stale = []
    try:
        goroot_env = patched_goroot(tmp)
        for project in sorted(set(PACKAGES.values())):
            pkgs = [p for p, pr in PACKAGES.items() if pr == project]
            # the toolchain etcd-grove translates with (the standard library goose type-checks against)
            # (a GOROOT with the standard-library reference implementations in place of the toolchain's)
            env = dict(goroot_env, GOFLAGS="-mod=mod")
            subprocess.run([goose] + lean_roots(project) + ["-out", os.path.join(tmp, project, "Code"),
                            "-configdir", os.path.join(GODIRS[project], "goose-config"), "-dir", GODIRS[project]] + pkgs,
                           check=True, env=env)
        for pkg in PACKAGES:
            path = pkg_path(pkg)
            defs, fields = [], []
            for rel in translation_files(os.path.join(tmp, PACKAGES[pkg], "Code"), path, pkg):
                with open(os.path.join(GROVE, "Code", rel)) as f:
                    old = f.readlines()
                with open(os.path.join(tmp, PACKAGES[pkg], "Code", rel)) as f:
                    new = f.readlines()
                d, fl = extract(old, new, pkg)
                defs += d
                fields += fl
            if not fields:
                sys.exit(f"goose-refimpl: {pkg}: no body translated (is its goose-config's translate list set?)")
            text = generate(pkg, path, defs, fields)
            dst = os.path.join(ROOT, "Refimpl", "Gen", path + ".lean")
            cur = open(dst).read() if os.path.exists(dst) else None
            if cur != text:
                stale.append(dst)
                if not args.check:
                    os.makedirs(os.path.dirname(dst), exist_ok=True)
                    with open(dst, "w") as f:
                        f.write(text)
            print(f"goose-refimpl: {pkg}: {len(fields)} binding(s), {sum(l.startswith('noncomputable def') for l in defs)} definition(s)")
    finally:
        shutil.rmtree(tmp)
    if args.check and stale:
        sys.exit("goose-refimpl: out of date: " + ", ".join(os.path.relpath(s, ROOT) for s in stale))


if __name__ == "__main__":
    main()
