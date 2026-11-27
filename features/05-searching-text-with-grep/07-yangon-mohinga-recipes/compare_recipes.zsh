#!/usr/bin/env zsh
# Searching text with grep · 07 · Yangon family, comparing two mohinga recipes
#
# Teaches:
#   - `grep -A N` prints N lines after each match; `-B N` prints N before; `-C N` is both
#   - context lines are marked with `-` instead of `:`; a `--` group separator sits between hits
#   - `-A`/`-B`/`-C` work with `-n` and with multiple files (`file:line:` on the match)
#   - useful when the interesting bit is the paragraph around a heading, not the heading alone
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/mohinga-yangon.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/*.txt $workdir/
cd -- "$workdir"

# region: after
# focus: grep -A3 '^Toppings:' aunt-thida.txt
print "== Aunt Thida's toppings (heading plus three lines):"
grep -A3 '^Toppings:' aunt-thida.txt
# endregion: after

# region: before
# focus: grep -B2 'banana stem' cousin-htet.txt
print "== Cousin Htet's note on banana stem, with two lines before:"
grep -B2 'banana stem' cousin-htet.txt
# endregion: before

# region: context
# focus: grep -C1 'fish sauce' *.txt
print "== fish sauce mentions in both recipes, one line of context:"
grep -C1 'fish sauce' *.txt
# endregion: context

# region: numbered-context
# focus: grep -nA2 '^Broth:' aunt-thida.txt
print "== Aunt Thida's broth, numbered:"
grep -nA2 '^Broth:' aunt-thida.txt
# endregion: numbered-context
