#!/usr/bin/env zsh
# Navigation and files · 03 · Reykjavík geothermal turbine inspection
#
# Teaches:
#   - cdpath lets `cd hellisheidi` work from any folder
#   - zsh's two-argument cd swaps one word of the current path for another
#   - cd_silent stops cd from echoing the folder it found through cdpath
#   - a plain cd into a sibling still works when cdpath has no match
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/orkuveita-round.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for plant in hellisheidi nesjavellir; do
  for turbine in turbine-1 turbine-2 turbine-3; do
    mkdir -p plants/$plant/$turbine/2026-11/vibration
  done
done
print "bearing 2: 4.1 mm/s, inside limit"   > plants/hellisheidi/turbine-2/2026-11/vibration/reading.txt
print "bearing 2: 7.8 mm/s, schedule a stop" > plants/hellisheidi/turbine-3/2026-11/vibration/reading.txt
print "bearing 2: 3.6 mm/s, inside limit"   > plants/nesjavellir/turbine-3/2026-11/vibration/reading.txt

where() { print "${1}: ${PWD#$workdir/}" }

# region: set-cdpath
# focus: cdpath=( $workdir/plants )
setopt cd_silent
cdpath=( $workdir/plants )
cd /
cd hellisheidi
where "from / via cdpath"
# endregion: set-cdpath

# region: walk-down
cd turbine-2/2026-11/vibration
where "walked down"
print "  $(< reading.txt)"
# endregion: walk-down

# region: swap-turbine
# focus: cd turbine-2 turbine-3
cd turbine-2 turbine-3
where "swapped turbine"
print "  $(< reading.txt)"
# endregion: swap-turbine

# region: swap-plant
# focus: cd hellisheidi nesjavellir
cd hellisheidi nesjavellir
where "swapped plant"
print "  $(< reading.txt)"
# endregion: swap-plant
