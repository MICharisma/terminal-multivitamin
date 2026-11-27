#!/usr/bin/env zsh
# requires: macos
# Sorting, counting, and columns · 13 · Kyoto calligraphy school, reflowing a practice stroke grid
#
# Teaches:
#   - BSD `rs` reshapes one-character-per-line grids into columns for printing
#   - `rs 0 4` keeps four columns per row and as many rows as needed
#   - `rs 0 2` reshapes the same grid into two columns for the narrow practice booklet
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "grid_reflow.zsh uses BSD rs, which ships on macOS"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/gion-brush.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/stroke-grid.txt $workdir/
cd -- "$workdir"

# region: rs-columns
# focus: rs -e 0 4 < stroke-grid.txt
print "== practice grid, four strokes per row:"
rs -e 0 4 < stroke-grid.txt
# endregion: rs-columns

# region: rs-narrow
# focus: rs -e 0 2 < stroke-grid.txt
print "== narrow booklet, two strokes per row:"
rs -e 0 2 < stroke-grid.txt
# endregion: rs-narrow