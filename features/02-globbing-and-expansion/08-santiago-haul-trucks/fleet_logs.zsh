#!/usr/bin/env zsh
# Globbing and expansion · 08 · Santiago mine maintenance office, haul truck telemetry
#
# Teaches:
#   - `<120-135>` matches any whole number in a range; `<->` matches any number
#   - `(n)` sorts matches numerically, so camion-99 comes before camion-101
#   - `(#i)` makes the rest of a pattern case-insensitive (needs `extended_glob`)
#   - `<200->` leaves the upper end of a range open
set -o errexit -o nounset -o pipefail
setopt extended_glob

workdir=$(mktemp -d "${TMPDIR:-/tmp}/el-teniente-flota.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for truck in 99 101 118 120 127 135 136 204 212; do
  print "payload 363 t, tyre 4 temp nominal" > camion-$truck.log
done
# The old dispatch system shouts in capitals.
print "payload 340 t, brake fade warning" > CAMION-131.LOG
print "weekly fuel summary"               > resumen-semanal.log

# region: lexical-order
# focus: camion-*.log
print "== plain glob, sorted as text:" camion-*.log
# endregion: lexical-order

# region: numeric-order
# focus: camion-<->.log(n)
print "== numeric order:" camion-<->.log(n)
# endregion: numeric-order

# region: shift-range
# focus: camion-<120-135>.log
print "== trucks 120 to 135 on the night shift:" camion-<120-135>.log
# endregion: shift-range

# region: any-case
# focus: (#i)camion-<120-135>.log
print "== same range, any case (picks up the old dispatch export):" (#i)camion-<120-135>.log
# endregion: any-case

# region: open-range
# focus: camion-<200->.log
print "== the new 200-series trucks:" camion-<200->.log
# endregion: open-range
