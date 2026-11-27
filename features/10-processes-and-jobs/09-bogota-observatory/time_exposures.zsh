#!/usr/bin/env zsh
# Processes and jobs · 09 · Bogotá observatory, timing plate exposures with zsh's time
#
# Teaches:
#   - zsh's `time` keyword times an external command and prints to stderr (not a shell function)
#   - `$TIMEFMT` shapes the report; include `%*E` (elapsed), `%*U` (user), `%*S` (system)
#   - redirect the report with `{ time ... } 2> timing.txt` so the script can read it back
#   - strip the digits so the expected output stays stable across machines
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/observatorio-nacional.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
plate=$1 frames=$2
for i in {1..$frames}; do
  print "plate $plate frame $i" >> $plate.fits.txt
  sleep 0.02
done' > expose.zsh
chmod +x expose.zsh

# region: timefmt
# focus: TIMEFMT='real %*E  user %*U  sys %*S'
TIMEFMT='real %*E  user %*U  sys %*S'
print "TIMEFMT is: $TIMEFMT"
# endregion: timefmt

# region: time-one
# focus: { time ./expose.zsh andes-nebula 5 } 2> timing.txt
{ time ./expose.zsh andes-nebula 5 } 2> timing.txt
print "== andes-nebula exposure:"
print "  frames: $(wc -l < andes-nebula.fits.txt | tr -d ' ')"
print "  $(sed -E 's/[0-9]+\.[0-9]+/N.NN/g' timing.txt)"
# endregion: time-one

# region: time-pipeline
# focus: { time ./expose.zsh orion-belt 3 } 2> timing.txt
{ time ./expose.zsh orion-belt 3 } 2> timing.txt
print "== orion-belt exposure:"
print "  frames: $(wc -l < orion-belt.fits.txt | tr -d ' ')"
print "  $(sed -E 's/[0-9]+\.[0-9]+/N.NN/g' timing.txt)"
# endregion: time-pipeline

# region: compare
# focus: TIMEFMT='%J  %*E seconds wall'
TIMEFMT='%J  %*E seconds wall'
{ time ./expose.zsh milky-way-core 4 } 2> timing.txt
print "== with a shorter TIMEFMT:"
print "  $(sed -E 's/[0-9]+\.[0-9]+/N.NN/g' timing.txt)"
# endregion: compare
