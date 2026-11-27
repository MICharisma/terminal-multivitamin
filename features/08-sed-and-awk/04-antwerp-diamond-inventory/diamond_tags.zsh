#!/usr/bin/env zsh
# Editing streams with sed and awk · 04 · Antwerp diamond inventory
#
# Teaches:
#   - `sed` capture groups use `\(...\)` and refer back with `\1` in the replacement
#   - `&` in the replacement inserts the whole matched text
#   - grouping rewrite rules in a `case` router keeps each certificate format separate
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/hoveniersstraat.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/inventory.tsv .

format_line() {
  local line=$1
  case $line in
    GIA-*)
      sed 's/\(GIA-\)\([0-9]*\)/stock GIA \2/' <<< $line
      ;;
    HRD-*)
      sed 's/HRD-\([0-9]*\)/& certified/' <<< $line
      ;;
    IGI-*)
      sed 's/\(IGI-\)\([0-9]*\)-\([A-Z]*\)/\1\2 cut \3/' <<< $line
      ;;
    *)
      print -- $line
      ;;
  esac
}

# region: backreference
# focus: format_line 'GIA-2145831220 1.02ct D VVS1'
print "== GIA numbers ready for the vault ledger:"
format_line 'GIA-2145831220 1.02ct D VVS1'
# endregion: backreference

# region: ampersand
# focus: format_line 'HRD-04015941002 0.91ct E VS2'
print "== HRD line keeps the lab prefix:"
format_line 'HRD-04015941002 0.91ct E VS2'
# endregion: ampersand

# region: case-router
# focus: format_line $line
print "== every line through the case router:"
while IFS= read -r line; do
  format_line $line
done < inventory.tsv
# endregion: case-router