#!/usr/bin/env zsh
# Navigation and files · 05 · Oaxaca recording studio, picking the latest takes
#
# Teaches:
#   - touch -t CCYYMMDDhhmm stamps a file with a chosen time (works on BSD and GNU)
#   - ls -t sorts newest first; ls -tr puts the oldest first
#   - touch -r copies one file's timestamp onto another
#   - an associative array keeps each take next to the time it was recorded
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/estudio-oaxaca.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -A recorded=(
  sandunga_take-01.wav    202611141905
  sandunga_take-02.wav    202611141932
  la-llorona_take-01.wav  202611141810
  la-llorona_take-02.wav  202611142047
  dios-nunca-muere_take-01.wav 202611142115
)

# region: stamp-takes
# focus: touch -t $stamp $take
for take stamp in ${(kv)recorded}; do
  : > $take
  touch -t $stamp $take
done
# endregion: stamp-takes

# region: newest-first
# focus: ls -t | head -n 3
print "== the band wants to hear the last three takes:"
ls -t | head -n 3
# endregion: newest-first

# region: oldest-first
# focus: ls -tr | head -n 1
print "== first take of the night: $(ls -tr | head -n 1)"
# endregion: oldest-first

# region: copy-stamp
# focus: touch -r la-llorona_take-02.wav la-llorona_mix-01.wav
: > la-llorona_mix-01.wav
touch -r la-llorona_take-02.wav la-llorona_mix-01.wav
print "== mix stamped like its source take, so it sorts beside it:"
ls -t | head -n 4
# endregion: copy-stamp
