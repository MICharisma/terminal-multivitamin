#!/usr/bin/env zsh
# Editing streams with sed and awk · 01 · Fez pottery glaze recipes
#
# Teaches:
#   - `sed 's/from/to/'` replaces only the first match on each line
#   - appending `g` to `s///` replaces every match on the line
#   - several `sed -e 'cmd'` expressions run in order on the same stream
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fassi-glazes.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p recipes
print 'chabakoua: 2oz water, 2oz frit-3124, 1oz cobalt carb' > recipes/chabakoua.txt
print 'tin-white: 4oz water, 1oz tin oxide, 0.5oz bentonite' > recipes/tin-white.txt

# region: first-only
# focus: sed 's/oz/ grams/'
print "== first oz on each line only:"
sed 's/oz/ grams/' recipes/chabakoua.txt
# endregion: first-only

# region: global-flag
# focus: sed 's/oz/ grams/g'
print "== every oz with the g flag:"
sed 's/oz/ grams/g' recipes/chabakoua.txt
# endregion: global-flag

# region: several-edits
# focus: sed -e 's/oz/ grams/g' -e 's/water/ H2O/g'
print "== glaze sheet ready for the electric kiln log:"
sed -e 's/oz/ grams/g' -e 's/water/ H2O/g' recipes/tin-white.txt
# endregion: several-edits