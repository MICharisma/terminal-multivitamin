#!/usr/bin/env zsh
# Sorting, counting, and columns · 07 · Amman architecture studio, tabulating facade heights
#
# Teaches:
#   - `column -t` aligns columns in fixed-width output; util-linux adds flags BSD lacks
#   - `column -s $'\t'` names the input separator so spaced columns still align
#   - both BSD and util-linux accept `-t -s` for simple TSV tables in the lesson
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/jabal-studios.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/facade-measures.tsv $workdir/
cd -- "$workdir"

format_board() {
  local title=$1
  local separator=$2
  print "== $title:"
  if [[ -n $separator ]]; then
    column -t -s $separator facade-measures.tsv
  else
    column -t facade-measures.tsv
  fi
}

# region: column-table
# focus: format_board "heights for the client PDF"
format_board "heights for the client PDF" ''
# endregion: column-table

# region: column-separator
# focus: format_board "same data, explicit tab separator" $'\t'
format_board "same data, explicit tab separator" $'\t'
# endregion: column-separator