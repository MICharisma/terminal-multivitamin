#!/usr/bin/env zsh
# Sorting, counting, and columns · 04 · Phnom Penh silk cooperative, matching weavers to dye lots
#
# Teaches:
#   - `join` only pairs lines when both files are sorted on the join field
#   - an unsorted second file makes join complain and can skip rows, even if `errexit` hides it
#   - `sort -t, -k1,1` sorts on the first comma field before a join on that key
#   - `join -t,` sets the field separator; without `-t` join expects blanks between columns
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/champey-silk.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/{weavers.csv,lots.csv} $workdir/
cd -- "$workdir"

# region: unsorted-join
# focus: join -t, -1 1 -2 1 weavers.csv lots.csv
join -t, -1 1 -2 1 weavers.csv lots.csv >unsorted.join.out 2>unsorted.join.err || true
unsorted_rows=$(( $(wc -l < unsorted.join.out | tr -d ' ') ))
unsorted_err=$(<unsorted.join.err)
rm -f unsorted.join.out unsorted.join.err
sorted_rows=$(sort -t, -k1,1 weavers.csv | join -t, -1 1 -2 1 - <(sort -t, -k1,1 lots.csv) | wc -l | tr -d ' ')
print "join on unsorted lots: $unsorted_rows rows (expect $sorted_rows), stderr: ${unsorted_err%%$'\n'*}"
# endregion: unsorted-join

# region: sort-for-join
# focus: sort -t, -k1,1 weavers.csv
sort -t, -k1,1 weavers.csv > weavers-by-id.csv
sort -t, -k1,1 lots.csv > lots-by-id.csv
print "weaver ids after sort: ${(f)$(cut -d, -f1 weavers-by-id.csv)}"
# endregion: sort-for-join

# region: comma-join
# focus: join -t, -1 1 -2 1 weavers-by-id.csv lots-by-id.csv
print "== weaver, lot, shade for the dye vats:"
join -t, -1 1 -2 1 weavers-by-id.csv lots-by-id.csv | while IFS=, read -r id name lot shade; do
  print "  $name ($id): $lot, $shade"
done
# endregion: comma-join