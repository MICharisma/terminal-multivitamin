#!/usr/bin/env zsh
# Editing streams with sed and awk · 13 · Vientiane temple palm-leaf archive
#
# Teaches:
#   - `sed` can transliterate angle tags; `awk` can repair fields when a delimiter slipped
#   - piping `sed` into `awk` keeps one pass for cleanup and another for aggregation
#   - a capstone report mixes literal `sed` edits with an awk summary table
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pha-that-luang.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/raw-shelf-export.txt .

emit_summary() {
  local cleaned=$1
  emulate -L zsh
  awk -F'|' '{
    leaves = ($3 != "" ? $3 : $4)
    shelf_leaves[$1] += leaves
    shelf_bundles[$1]++
  } END {
    for (shelf in shelf_leaves)
      printf "shelf %s: %d bundles, %d leaves\n", shelf, shelf_bundles[shelf], shelf_leaves[shelf]
  }' $cleaned | sort
}

# region: transliterate-tags
# focus: sed -e 's/<bundle>/|/g'
print "== normalized delimiters:"
sed -e 's/<bundle>/|/g' -e 's/<\/bundle>//g' -e 's/<leaf>/|/g' -e 's/<\/leaf>/|/g' \
  raw-shelf-export.txt > cleaned.tsv
sed -n '1,3p' cleaned.tsv
# endregion: transliterate-tags

# region: repair-fields
# focus: awk -F'|'
print "== rows with repaired leaf counts:"
awk -F'|' '{
    if ($3 != "") {
      leaves = $3
      scribe = ($4 == "" ? "unknown" : $4)
    } else {
      leaves = $4
      scribe = ($5 == "" ? "unknown" : $5)
    }
  if (leaves != "") printf "%s bundle %s: %s leaves, scribe %s\n", $1, $2, leaves, scribe
}' cleaned.tsv
# endregion: repair-fields

# region: summary-table
# focus: emit_summary
print "== totals for the restoration workshop:"
emit_summary cleaned.tsv
# endregion: summary-table