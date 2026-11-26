#!/usr/bin/env zsh
# Sorting, counting, and columns · 02 · Addis Ababa running club, sorting the Entoto time trial
#
# Teaches:
#   - `sort -t, -k4,4` compares the fourth comma-separated field as text, so 10 sorts before 5
#   - `-k4,4n` compares it as a number; a second key `-k5,5` breaks ties by time
#   - `-k3` means "from field 3 to the end of the line", not "field 3"; `-k3,3` stops at field 3
#   - a flag on one key, as in `-k4,4nr`, reverses only that key
#   - `mm:ss` times of the same width sort correctly as text
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/entoto-runners.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/entoto-trial-2026-11-22.csv $workdir/
cd -- "$workdir"

tail -n +2 entoto-trial-2026-11-22.csv > results.csv
show() {
  local bib runner group km time
  while IFS=, read -r bib runner group km time; do
    printf '  %-15s %-10s %2s km %s\n' $runner $group $km $time
  done
}

# region: text-key
# focus: sort -t, -k4,4 results.csv
print "distances sorted as text:    ${(f)"$(sort -t, -k4,4 results.csv | cut -d, -f4)"}"
# endregion: text-key

# region: numeric-key
# focus: sort -t, -k4,4n -k5,5 results.csv
print "distances sorted as numbers: ${(f)"$(sort -t, -k4,4n results.csv | cut -d, -f4)"}"
print "== by distance, fastest first within each:"
sort -t, -k4,4n -k5,5 results.csv | show
# endregion: numeric-key

# region: open-ended-key
# focus: sort -t, -k3 -k5,5
print "== men-open with -k3: after the group, sort keeps comparing km as text:"
sort -t, -k3 -k5,5 results.csv | grep ',men-open,' | show
print "== men-open with -k3,3 -k5,5: group, then time:"
sort -t, -k3,3 -k5,5 results.csv | grep ',men-open,' | show
# endregion: open-ended-key

# region: reverse-one-key
# focus: sort -t, -k4,4nr -k5,5
print "== the coach's board: longest distance first, fastest first within it:"
sort -t, -k4,4nr -k5,5 results.csv | show
# endregion: reverse-one-key
