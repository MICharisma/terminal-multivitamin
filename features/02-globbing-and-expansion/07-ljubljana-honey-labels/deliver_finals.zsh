#!/usr/bin/env zsh
# Globbing and expansion · 07 · Ljubljana beekeeping cooperative label photos
#
# Teaches:
#   - `extended_glob`, switched on only inside a function (`emulate -L zsh`) or
#     an anonymous function (`setopt local_options`)
#   - `^pattern` matches everything except the pattern
#   - `pattern~exclusion` keeps matches of the first part that miss the second
#   - `(a|b)` alternation and `*.(jpg|png)` pick between several spellings
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cebelarji-labels.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir shoot delivery
for honey in akacija lipa kostanj cvetlicni; do
  for frame in 01 02; do
    : > shoot/${honey}_jar-${frame}.cr3
    : > shoot/${honey}_jar-${frame}.jpg
  done
  : > shoot/${honey}_jar-02_draft.jpg
done
: > shoot/kranjska-cebela_logo.png
: > shoot/kranjska-cebela_logo_draft.png
: > shoot/contact-sheet.pdf

# region: scoped-option
# focus: emulate -L zsh
finals_in() {
  emulate -L zsh
  setopt extended_glob
  # endregion: scoped-option
  # region: exclude-drafts
  # focus: $1/*.(jpg|png)~*_draft*
  print -l -- $1/*.(jpg|png)~*_draft*(N)
  # endregion: exclude-drafts
}

# region: negate-raw
# focus: ^*.cr3
() {
  setopt local_options extended_glob
  local -a not_raw=( shoot/^*.cr3 )
  print "everything in the shoot that is not a camera RAW: ${#not_raw} files"
}
# endregion: negate-raw

# region: deliver
# focus: cp -- $finals delivery/
finals=( ${(f)"$(finals_in shoot)"} )
cp -- $finals delivery/
print "== delivered to the label printer in Kranj:"
ls -1 delivery
# endregion: deliver

# region: alternation
# focus: (akacija|lipa)_*
print "== the two honeys going to the Vienna fair:"
cd delivery
print -l (akacija|lipa)_*
# endregion: alternation
