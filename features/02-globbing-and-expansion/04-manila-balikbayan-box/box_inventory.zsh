#!/usr/bin/env zsh
# Globbing and expansion · 04 · Quezon City family balikbayan box lists
#
# Teaches:
#   - glob qualifiers filter by file type: (.) plain files, (/) folders, (@) symlinks
#   - (-/) follows symlinks first, so a link to a folder counts as a folder
#   - qualifiers combine: (/^F) is "folders that are not full", i.e. empty
#   - (N) makes an empty match an empty list instead of an error
#   - ${~pattern} lets a pattern stored in a variable glob when expanded,
#     but only outside double quotes: "${~pattern}" stays literal text
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/balikbayan.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p kahon/tita-marites_dubai-2026-11 kahon/kuya-jun_toronto-2026-10 kahon/ate-liza_milan-2026-12
print "corned beef x12, Toblerone x6, rubber shoes for Paolo (size 8)" > kahon/tita-marites_dubai-2026-11/listahan.txt
print "maple syrup x4, winter jacket for Lola, Spam x10"              > kahon/kuya-jun_toronto-2026-10/listahan.txt
print "door-to-door, LBC tracking BX-2026-118842"                      > kahon/padala-tracking.txt
print "who sends what for Christmas: Tita Marites, Kuya Jun, Ate Liza"  > kahon/plano-pasko.txt
ln -s tita-marites_dubai-2026-11 kahon/pinakabago
ln -s padala-tracking.txt kahon/tracking

cd kahon

# region: kinds-table
# focus: ${~kinds[$kind]}
typeset -A kinds=(
  folders        '*(/)'
  files          '*(.)'
  symlinks       '*(@)'
  folders-or-links-to-them '*(-/)'
)
for kind in folders files symlinks folders-or-links-to-them; do
  print -- "${(r:26:)kind}" ${~kinds[$kind]}
done
# endregion: kinds-table

# region: empty-folders
# focus: *(/^F)
print "== relatives who have not sent a list yet (empty folders):"
print -l *(/^F)
# endregion: empty-folders

# region: no-match
# focus: *.xlsx(N)
spreadsheets=( *.xlsx(N) )
print "== spreadsheets from Tito Ramon: ${#spreadsheets}"
# endregion: no-match

# region: lists-inside
# focus: */listahan.txt(.)
print "== lists received:"
for list in */listahan.txt(.); do
  print "${list:h}: $(< $list)"
done
# endregion: lists-inside
