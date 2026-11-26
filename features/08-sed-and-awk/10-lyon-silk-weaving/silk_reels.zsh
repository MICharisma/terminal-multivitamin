#!/usr/bin/env zsh
# Editing streams with sed and awk · 10 · Lyon silk weaving
#
# Teaches:
#   - awk associative arrays count occurrences with `count[key]++`
#   - the same array shape can sum a numeric field per key in one pass
#   - iterating `for (key in arr)` is unordered; pipe through `sort` for a report
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/saint-georges.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/loom-spools.tsv .

# region: freq-array
# focus: lots[$2]++
print "== threads per dye lot:"
awk -F'\t' '{ lots[$2]++ } END {
  for (lot in lots) print lots[lot], lot
}' loom-spools.tsv | sort -rn
# endregion: freq-array

# region: sum-array
# focus: metres[$1] +=
print "== metres wound per loom:"
awk -F'\t' '{ metres[$1] += $3 } END {
  for (loom in metres) print metres[loom], loom
}' loom-spools.tsv | sort -rn
# endregion: sum-array

# region: for-loop-report
# focus: case $role in
for role in count sum; do
  case $role in
    count) print "  lots tracked: $(awk -F'\t' '{ lots[$2]++ } END { print length(lots) }' loom-spools.tsv)" ;;
    sum)   print "  looms tracked: $(awk -F'\t' '{ metres[$1] += $3 } END { print length(metres) }' loom-spools.tsv)" ;;
  esac
done
# endregion: for-loop-report