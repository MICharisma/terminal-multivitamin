#!/usr/bin/env zsh
# Archives and compression · 07 · Phnom Penh build bundle
#
# Teaches:
#   - `tar --exclude` skips heavy folders like `node_modules` while packing the rest
#   - `tar -tf` afterwards proves the excluded paths never entered the archive
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/phnom-penh-build.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p app/src app/node_modules/lodash app/dist
print "export function greet() { return 'sok sabai' }" > app/src/greet.js
print "bundle placeholder"                            > app/dist/main.js
print "lodash internals, do not ship"                 > app/node_modules/lodash/index.js
print '{"name":"greet-kh"}'                           > app/package.json

# region: pack-excluding
# focus: --exclude=node_modules
tar -czf greet-kh.tgz --exclude=node_modules -C app .
print "== packed greet-kh.tgz without node_modules"
# endregion: pack-excluding

# region: prove-exclusion
# focus: tar -tf greet-kh.tgz
print "== archive members:"
# Drop directory-only entries and leading ./ so BSD/GNU listings match.
tar -tf greet-kh.tgz | sed 's|^\./||' | grep -v '/$' | grep -v '^$' | sort
print "== node_modules mentioned?"
if tar -tf greet-kh.tgz | grep -q node_modules; then
  print "  yes (unexpected)"
else
  print "  no"
fi
# endregion: prove-exclusion
