#!/usr/bin/env zsh
# Navigation and files · 12 · Helsinki music academy practice-room cleanup
#
# Teaches:
#   - `${var:?message}` stops the script before `rm -r` can run on an empty path
#   - `mv --` and `rm --` handle a file whose name starts with a dash
#   - `rmdir` removes only empty folders, so it is a safe sweep after moving files
#   - `rm -f` is quiet about files that are already gone
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/harjoitushuoneet.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p rooms/r214/2026-10 rooms/r214/2026-11 rooms/r301/2026-10 rooms/r301/2026-11 keep
print "Sibelius violin concerto, mvt 1, Aino" > rooms/r214/2026-11/aino_sibelius-op47.wav
print "kantele étude, take 1, Eero"          > rooms/r301/2026-10/eero_kantele-etude.wav
print "kantele étude, take 3 (the good one)" > rooms/r301/2026-10/-take3.wav

# region: dash-filename
# focus: mv -- -take3.wav
cd rooms/r301/2026-10
if ! rm -take3.wav 2>/dev/null; then
  print "rm -take3.wav: rm read the name as options"
fi
mv -- -take3.wav $workdir/keep/eero_kantele-etude_take3.wav
rm -- eero_kantele-etude.wav
print "kept Eero's take 3; removed take 1 with rm --"
cd -- "$workdir"
# endregion: dash-filename

# region: sweep-empty
# focus: rmdir -- $month
for month in rooms/*/*; do
  if rmdir -- $month 2>/dev/null; then
    print "rmdir: removed empty ${month#rooms/}"
  else
    print "rmdir: kept ${month#rooms/} (still has recordings)"
  fi
done
# endregion: sweep-empty

# region: guard-variable
# focus: ${archive_room:?no room given}
clear_room() {
  local archive_room=${1-}
  rm -r -- "${archive_room:?no room given}"
}
if ! ( clear_room "" ) 2>/dev/null; then
  print "clear_room with an empty name: stopped before rm ran"
fi
clear_room rooms/r301
print "clear_room rooms/r301: done"
# endregion: guard-variable

# region: quiet-force
# focus: rm -f -- rooms/r301/notes.txt
rm -f -- rooms/r301/notes.txt && print "rm -f on a missing file: no complaint"
print "== what is left:"
ls -1 rooms keep
# endregion: quiet-force
