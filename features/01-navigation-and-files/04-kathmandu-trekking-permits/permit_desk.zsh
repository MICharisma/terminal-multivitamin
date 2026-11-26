#!/usr/bin/env zsh
# Navigation and files · 04 · Kathmandu trekking permit desk
#
# Teaches:
#   - head -n 1 reads a CSV header; tail -n +2 skips it
#   - tail -n 3 shows the latest rows of a log that grows at the bottom
#   - head -n 7 | tail -n 3 cuts a window out of the middle of a file
#   - wc -l pads its count on macOS (BSD); $(( )) turns it back into a number
#   - cat -n numbers lines for a phone call about "row 6"
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/thamel-permits.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/permits.csv $workdir/
cd -- "$workdir"

# region: read-header
# focus: head -n 1 permits.csv
print "columns: $(head -n 1 permits.csv)"
# endregion: read-header

# region: count-trekkers
# focus: tail -n +2 permits.csv | wc -l
trekkers=$(( $(tail -n +2 permits.csv | wc -l) ))
print "permits issued: $trekkers"
# endregion: count-trekkers

# region: latest-permits
# focus: tail -n 3 permits.csv
print "== latest three at the desk:"
tail -n 3 permits.csv
# endregion: latest-permits

# region: middle-window
# focus: head -n 7 permits.csv | tail -n 3
print "== rows 5 to 7 (the Langtang group that called back):"
head -n 7 permits.csv | tail -n 3
# endregion: middle-window

# region: number-lines
# focus: cat -n
print "== numbered, so the office in Pokhara can say \"line 6\":"
tail -n +2 permits.csv | cat -n | head -n 6
# endregion: number-lines
