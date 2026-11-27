#!/usr/bin/env zsh
# Sorting, counting, and columns · 06 · Dhaka garment packing, lining up carton labels
#
# Teaches:
#   - `paste` merges lines from files side by side, column by column
#   - `paste -d:` uses one delimiter between merged fields
#   - `paste -s` serial mode turns each file into one row (or transposes a single file)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ashulia-cartons.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/{carton-ids.txt,carton-sizes.txt,carton-colors.txt} $workdir/
cd -- "$workdir"

# region: paste-default
# focus: paste carton-ids.txt carton-sizes.txt carton-colors.txt
print "== default tabs between parallel columns:"
paste carton-ids.txt carton-sizes.txt carton-colors.txt
# endregion: paste-default

# region: paste-delimiter
# focus: paste -d: carton-ids.txt carton-sizes.txt carton-colors.txt
print "== colon-separated for the laser printer:"
paste -d: carton-ids.txt carton-sizes.txt carton-colors.txt
# endregion: paste-delimiter

# region: paste-serial
# focus: paste -s -d' ' carton-ids.txt
print "== serial mode: one line listing every carton id:"
paste -s -d' ' carton-ids.txt
print "== and one line per size-color pair from two files:"
paste -s carton-sizes.txt carton-colors.txt
# endregion: paste-serial