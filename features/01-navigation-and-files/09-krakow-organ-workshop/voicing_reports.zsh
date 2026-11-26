#!/usr/bin/env zsh
# Navigation and files · 09 · Kraków organ workshop voicing reports
#
# Teaches:
#   - `stat` takes different flags on macOS (BSD: `-f %z`) and Linux (GNU: `-c %s`)
#   - detecting GNU `stat` once and defining one function for both
#   - zsh's own `zstat` (the `zsh/stat` module) answers the same question everywhere
#   - `[[ a -nt b ]]` compares modification times; `[[ -s f ]]` means "not empty"
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/warsztat-organowy.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir ranks
print "Pryncypał 8': pipes C-c3 regulated, mouths raised 0.5 mm on f2-a2" > ranks/pryncypal-8.txt
print "Bourdon 16': stoppers re-leathered, speech even across the compass\nTwo notes (G#, A) still slow to speak" > ranks/bourdon-16.txt
print "Trompeta 8': reeds cleaned, tongues recurved" > ranks/trompeta-8.txt
: > ranks/vox-humana-8.txt
print "last full service of the Mariacki organ" > service-2026-09.txt

touch -t 202609300900 service-2026-09.txt
touch -t 202611120800 ranks/pryncypal-8.txt
touch -t 202608150800 ranks/trompeta-8.txt
touch -t 202611210800 ranks/bourdon-16.txt
touch -t 202611210815 ranks/vox-humana-8.txt

# region: pick-stat
# focus: stat --version
if stat --version >/dev/null 2>&1; then
  size_of() { stat -c %s -- $1 }
  print "stat flavour: GNU (stat -c %s)"
else
  size_of() { stat -f %z -- $1 }
  print "stat flavour: BSD (stat -f %z)"
fi
# endregion: pick-stat

# region: read-sizes
# focus: size_of $report
for report in ranks/*.txt; do
  printf '%-26s %4d bytes\n' ${report:t} $(size_of $report)
done
# endregion: read-sizes

# region: zstat-check
# focus: zstat -A bytes +size -- ranks/bourdon-16.txt
zmodload -F zsh/stat b:zstat
zstat -A bytes +size -- ranks/bourdon-16.txt
print "zstat agrees on bourdon-16.txt: $bytes[1] bytes"
# endregion: zstat-check

# region: newer-than-service
# focus: [[ $report -nt service-2026-09.txt ]]
print "== reports written since the September service:"
for report in ranks/*.txt; do
  if [[ $report -nt service-2026-09.txt ]]; then
    if [[ -s $report ]]; then
      print "  ${report:t}"
    else
      print "  ${report:t} (empty: the voicer has not written it up yet)"
    fi
  fi
done
# endregion: newer-than-service
