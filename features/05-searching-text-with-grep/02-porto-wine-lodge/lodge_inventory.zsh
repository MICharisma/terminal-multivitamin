#!/usr/bin/env zsh
# Searching text with grep · 02 · Porto wine lodge, finding bottles in the inventory
#
# Teaches:
#   - `grep -i` ignores case: `tawny` matches `Tawny` and `TAWNY`
#   - `grep -w` matches a whole word: `Ruby` matches, `Rub` does not
#   - `-i` and `-w` combine; the pattern can still use basic regex
#   - note: GNU grep treats `-` as a word boundary, so `-w 20` *does* match inside `20-year`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cave-vila-nova.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -l \
  "bin-A12 Taylor Fladgate 20-year Tawny, 750ml, 3 bottles" \
  "bin-A14 Taylor Fladgate Late Bottled Vintage 2018, 750ml, 6 bottles" \
  "bin-B03 Graham's 40-year Tawny, 750ml, 1 bottle" \
  "bin-B07 Quinta do Noval Vintage 2011, 750ml, 2 bottles" \
  "bin-C01 Fonseca Bin 27 Ruby, 750ml, 12 bottles" \
  "bin-C09 Graham's Six Grapes Reserve, 750ml, 8 bottles" \
  "bin-D02 Taylor Fladgate 10-year Tawny, 375ml, 4 bottles" > inventory.txt

# region: case-insensitive
# focus: grep -i tawny inventory.txt
print "== every Tawny, any capitalisation:"
grep -i tawny inventory.txt
# endregion: case-insensitive

# region: whole-word
# focus: grep -w Ruby inventory.txt
print "== whole word Ruby:"
grep -w Ruby inventory.txt
print "== whole word Rub (the letters are there, but not as a word):"
if ! grep -w Rub inventory.txt; then
  print "(none)"
fi
# endregion: whole-word

# region: both
# focus: grep -icw Tawny inventory.txt
print "Tawny bottles on the lodge floor: $(grep -icw Tawny inventory.txt) lines"
# endregion: both
