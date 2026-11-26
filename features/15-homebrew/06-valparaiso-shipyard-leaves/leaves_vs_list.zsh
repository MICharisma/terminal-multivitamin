#!/usr/bin/env zsh
# Homebrew · 06 · Valparaíso shipyard leaves vs list
#
# Teaches:
#   - `brew list` names every installed formula, including dependencies
#   - `brew leaves` keeps only formulae you asked for (nothing else depends on them)
#   - `comm` compares two sorted lists: only-left, only-right, and both
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/asmar-shipyard-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: list-all
# focus: brew list
brew list --formula | sort > installed.txt
print "installed formulae: $(wc -l < installed.txt | tr -d ' ')"
# endregion: list-all

# region: leaves-only
# focus: brew leaves
brew leaves | sort > leaves.txt
print "leaves (requested): $(wc -l < leaves.txt | tr -d ' ')"
# endregion: leaves-only

# region: comm-deps
# focus: comm -23
print "== dependencies you never typed (list minus leaves):"
comm -23 installed.txt leaves.txt
print "== requested tools still on the cart:"
comm -12 installed.txt leaves.txt
# endregion: comm-deps
