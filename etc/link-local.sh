#!/bin/sh
# Build against a local etcd-grove instead of cloning it (and rebuilding it from scratch).
# Usage: etc/link-local.sh /path/to/etcd-grove-checkout
# The checkout must be at the `rev` lakefile.toml pins for etcdGrove, and built (`lake build`, or at
# least the modules imported here); its .lake/packages provide Perennial, Iris, batteries and Qq.
set -e
G=$(realpath "${1:?usage: etc/link-local.sh /path/to/etcd-grove}")
cd "$(dirname "$0")/.."
mkdir -p .lake/packages
ln -sfn "$G" .lake/packages/etcdGrove
for d in "$G"/.lake/packages/*; do ln -sfn "$(realpath "$d")" ".lake/packages/$(basename "$d")"; done
ls -l .lake/packages
