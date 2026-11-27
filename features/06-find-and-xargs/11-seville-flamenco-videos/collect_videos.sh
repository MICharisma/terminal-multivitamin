#!/usr/bin/env bash
# Finding files with find and xargs · 11 · Seville flamenco academy, collecting rehearsal videos, in bash
#
# Teaches:
#   - in bash, `find ... | while read` runs the loop in a subshell, so a counter set inside it is lost
#   - `while IFS= read -r -d '' video; do ...; done < <(find ... -print0)` keeps the loop in
#     the current shell and reads NUL-separated names safely
#   - `videos+=("$video")` builds an array that works in macOS's bash 3.2, which has no `mapfile -d`
#   - `${rel//\//__}` flattens a path into one file name, so two pupils' `alegrias.mov` don't collide
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/academia-triana.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for video in "maria jose ruiz/alegrias.mov" "maria jose ruiz/soleares.mov" \
             "antonio de la vega/alegrias.mov" "antonio de la vega/bulerias.mov" \
             "lucia-moreno/sevillanas.mov"; do
  mkdir -p "academia/${video%/*}"
  echo "rehearsal video, studio 2, Triana" > "academia/$video"
done
echo "class timetable, autumn term" > academia/horario.txt

# region: lost-count
# focus: find academia -name '*.mov' | while read -r video; do
count=0
find academia -name '*.mov' | while read -r video; do
  count=$((count + 1))
done
echo "counted through a pipe: $count (the loop ran in a subshell)"
# endregion: lost-count

# region: process-substitution
# focus: done < <(find academia -name '*.mov' -print0)
videos=()
while IFS= read -r -d '' video; do
  videos+=("$video")
done < <(find academia -name '*.mov' -print0)
echo "counted with process substitution: ${#videos[@]}"
# endregion: process-substitution

# region: flatten-names
# focus: ${rel//\//__}
mkdir festival-reel
for video in "${videos[@]}"; do
  rel=${video#academia/}
  cp -- "$video" "festival-reel/${rel//\//__}"
done
echo "== festival-reel/, one file per pupil and dance:"
ls -1 festival-reel
# endregion: flatten-names
