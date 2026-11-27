#!/usr/bin/env zsh
# Globbing and expansion · 05 · Bergen weather radar archive, sizing the sweeps
#
# Teaches:
#   - `(L0)` finds empty files; `(Lk+100)` finds files over 100 KiB
#   - `(OL)` sorts largest first; `[1,3]` keeps the first three matches
#   - `(oL)` sorts smallest first; `(.)` keeps plain files only
#   - qualifiers stack in one set of parentheses; `^` negates the ones after it,
#     so `(.Lk-50oL^L0)` is "plain, under 50 KiB, smallest first, not empty"
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/radar-hurum.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# Kilobytes per volume scan; a 0 is a sweep the radar dropped during the storm.
typeset -A sweep_kib=(
  hurum_2026-11-20T0600.h5 180
  hurum_2026-11-20T0615.h5 210
  hurum_2026-11-20T0630.h5 0
  hurum_2026-11-20T0645.h5 46
  hurum_2026-11-20T0700.h5 260
  hurum_2026-11-20T0715.h5 0
  hurum_2026-11-20T0730.h5 32
)
for sweep kib in ${(kv)sweep_kib}; do
  head -c $(( kib * 1024 )) /dev/zero > $sweep
done
mkdir quicklooks

# region: dropped-sweeps
# focus: *.h5(L0)
print "== dropped sweeps to re-request from the radar:"
print -l *.h5(L0)
# endregion: dropped-sweeps

# region: storm-cells
# focus: *.h5(Lk+100)
print "== full-volume scans (over 100 KiB), probably the storm cell:"
print -l *.h5(Lk+100)
# endregion: storm-cells

# region: largest-three
# focus: *.h5(OL[1,3])
print "== three largest, for the forecaster on duty:"
for sweep in *.h5(OL[1,3]); do
  print "$sweep $(( $(wc -c < $sweep) / 1024 )) KiB"
done
# endregion: largest-three

# region: stacked-qualifiers
# focus: *(.Lk-50oL^L0)
print "== small but not empty, smallest first (clear-air scans):"
print -l *(.Lk-50oL^L0)
# endregion: stacked-qualifiers
