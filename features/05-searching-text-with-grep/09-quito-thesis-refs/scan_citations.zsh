#!/usr/bin/env zsh
# Searching text with grep · 09 · Quito university thesis, scanning citations
#
# Teaches:
#   - `grep -e pat1 -e pat2` matches either pattern (same idea as `pat1|pat2` with `-E`)
#   - `grep -f patterns.txt` reads one pattern per line from a file
#   - `-f` and `-e` combine; `-f` is how a bibliography checklist stays editable
#   - patterns from a file are basic regex unless you add `-F` or `-E`
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/puce-tesis.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/* $workdir/
cd -- "$workdir"

# region: multiple-e
# focus: grep -e Murra -e Salomon chapter-2.txt
print "== supervisor's two required authors:"
grep -e Murra -e Salomon chapter-2.txt
# endregion: multiple-e

# region: from-file
# focus: grep -n -f patterns.txt chapter-2.txt
print "== every author on the reading-list file:"
grep -n -f patterns.txt chapter-2.txt
# endregion: from-file

# region: missing-from-list
# focus: grep -n -e Horkheimer -e 'Espinoza Soriano'
print "== authors cited but not yet on patterns.txt:"
grep -n -e Horkheimer -e 'Espinoza Soriano' chapter-2.txt
# endregion: missing-from-list

# region: fixed-from-file
# focus: grep -c -Ff patterns.txt chapter-2.txt
print "checklist hits (fixed strings): $(grep -c -Ff patterns.txt chapter-2.txt)"
# endregion: fixed-from-file
