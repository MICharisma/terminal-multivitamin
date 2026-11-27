#!/usr/bin/env zsh
# Editing streams with sed and awk · 09 · Muscat date farm grades
#
# Teaches:
#   - `awk printf` formats numbers without the default newline `print` adds
#   - `% width` and `%-width` align text in fixed columns
#   - `%.2f` rounds a field to two decimal places for a moisture report
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/nizwa-dates.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/grading.tsv .

typeset -A packer=(
  [khalas]=nasser
  [fard]=salim
  [naghal]=amina
)

# region: printf-columns
# focus: printf "%-12s %6s %s\n"
print "== packing slip for the souq:"
awk -F'\t' '{ printf "%-12s %6s %s\n", $1, $2, $3 }' grading.tsv
# endregion: printf-columns

# region: fixed-decimals
# focus: %.2f%%
print "== moisture column for export:"
awk -F'\t' '{ printf "%s moisture %.2f%%\n", $1, $4 }' grading.tsv
# endregion: fixed-decimals

# region: assign-packer
# focus: ${(kv)packer}
print "== who grades which variety:"
for variety handler in ${(kv)packer}; do
  printf '  %-8s -> %s\n' $variety $handler
done
# endregion: assign-packer