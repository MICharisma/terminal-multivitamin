#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 08 · Lhasa archive catalog queries
#
# Teaches:
#   - an associative array holds shelf → query pairs
#   - `mdfind` runs each query; empty results are fine in a temp sandbox
#   - the ledger records query text and exit status, never fluctuating hit lists
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "catalog_queries.zsh uses mdfind, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/lhasa-archive.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -A queries
queries=(
  woodblocks 'kMDItemTextContent == "woodblock"c'
  thangka    'kMDItemDisplayName == "*thangka*"c'
)

# region: kv-queries
# focus: ${(kv)queries}
typeset -A snap
snap=( ${(kv)queries} )
# endregion: kv-queries

# region: run-mdfind
# focus: mdfind
for shelf in ${(ok)snap}; do
  query=$snap[$shelf]
  print "shelf $shelf query: $query"
  if mdfind "$query" >/dev/null 2>&1; then
    print "shelf $shelf mdfind: ok"
  else
    print "shelf $shelf mdfind: failed"
  fi
done
# endregion: run-mdfind
