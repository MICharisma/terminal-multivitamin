#!/usr/bin/env zsh
# Globbing and expansion · 01 · Nairobi Coffee Exchange auction catalogue
#
# Teaches:
#   - * matches any run of characters; ? matches exactly one
#   - [AP][AB] matches one character from each set (AA, AB, PB...)
#   - [^C] (or [!C]) matches any one character except C
#   - quoting a pattern turns globbing off, so the shell passes it literally
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/nce-catalogue.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for lot in lot-0412_kiambu_AA lot-0413_kiambu_AB lot-0418_nyeri_AA lot-0419_nyeri_PB \
           lot-0425_kirinyaga_C lot-0426_kirinyaga_TT lot-1102_embu_AB lot-1107_muranga_E; do
  print "cupping score sheet for ${lot}" > $lot.csv
done

# region: one-grade
# focus: *_AA.csv
print "== every AA lot, for the Hamburg roaster:"
print -l *_AA.csv
# endregion: one-grade

# region: fixed-width
# focus: lot-04??_*
print "== the 04xx lots from this week's catalogue:"
print -l lot-04??_*
# endregion: fixed-width

# region: character-sets
# focus: *_[AP][AB].csv
print "== top screen grades (AA, AB, PB) for the Seoul buyer:"
print -l *_[AP][AB].csv
# endregion: character-sets

# region: negated-set
# focus: lot-04[0-9][0-9]_*_[^AP]*.csv
print "== lower grades in the 04xx series:"
print -l lot-04[0-9][0-9]_*_[^AP]*.csv
# endregion: negated-set

# region: quoted-pattern
# focus: '*_AA.csv'
print "== quoted, the shell leaves it alone:" '*_AA.csv'
# endregion: quoted-pattern
