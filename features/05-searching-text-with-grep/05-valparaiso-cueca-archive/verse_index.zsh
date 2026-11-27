#!/usr/bin/env zsh
# Searching text with grep · 05 · Valparaíso cueca archive, indexing the verses
#
# Teaches:
#   - `grep -n` prefixes each match with its line number; add `-i` to ignore case: `5:Cueca brava...`
#   - `grep -o` prints only the matching part, not the whole line (one match per line by default)
#   - `-o` with `-n` still shows the line number of each match piece
#   - `-E` plus `-o` pulls every `pañuelo` out of a line that holds two
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/cueca-valparaiso.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/verses.txt $workdir/
cd -- "$workdir"

# region: line-numbers
# focus: grep -ni cueca verses.txt
print "== lines that mention cueca, with numbers for the binder:"
grep -ni cueca verses.txt
# endregion: line-numbers

# region: only-match
# focus: grep -oi 'pañuelo[^,]*' verses.txt
print "== each pañuelo phrase, nothing else:"
grep -oi 'pañuelo[^,]*' verses.txt
# endregion: only-match

# region: numbered-pieces
# focus: grep -noi 'cueca[^,]*' verses.txt
print "== cueca phrases with their verse numbers:"
grep -noi 'cueca[^,]*' verses.txt
# endregion: numbered-pieces

# region: all-on-line
# focus: grep -Eoi 'pañuelo [a-zá]+' verses.txt
print "== every pañuelo + next word (one -o match per hit):"
grep -Eoi 'pañuelo [a-zá]+' verses.txt
# endregion: all-on-line
