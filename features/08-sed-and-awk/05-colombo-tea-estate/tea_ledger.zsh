#!/usr/bin/env zsh
# Editing streams with sed and awk · 05 · Colombo tea estate ledger
#
# Teaches:
#   - `sed -i.bak` edits a file in place and leaves `file.bak` on both BSD and GNU sed
#   - GNU `sed -i` with no extension edits in place with no backup; BSD needs `sed -i ''`
#   - detecting GNU once with `sed --version` keeps one helper behind both behaviors
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dimbula-estate.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/field-ledger.txt ledger.txt

# region: portable-bak
# focus: sed -i.bak
cp ledger.txt ledger-before.txt
sed -i.bak 's/rupee/ LKR/g' ledger.txt
print "== in-place with a .bak sibling:"
print "  ledger: $(<ledger.txt)"
print "  backup: $(<ledger.txt.bak)"
# endregion: portable-bak

# region: detect-inplace
# focus: sed --version
if sed --version >/dev/null 2>&1; then
  sed_inplace() { sed -i "$@"; }
else
  sed_inplace() { sed -i '' "$@"; }
fi
# endregion: detect-inplace

# region: no-backup
# focus: sed_inplace
cp ledger-before.txt ledger-nobak.txt
sed_inplace 's/plucker/ picker/g' ledger-nobak.txt
print "== no backup file after GNU or BSD -i:"
print "  $(<ledger-nobak.txt)"
print "  backup exists: $([[ -e ledger-nobak.txt.bak ]] && print yes || print no)"
# endregion: no-backup