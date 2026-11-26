#!/usr/bin/env bash
# Globbing and expansion · 11 · Zanzibar reef survey photos, in bash
#
# Teaches:
#   - bash needs `shopt -s extglob` for `@(a|b)`, `+(digits)`, and `!(pattern)`
#   - `extglob` must be on before bash parses the line that uses it, so set it
#     near the top, not inside the function that needs it
#   - `nocaseglob` lets `*.jpg` match the camera's `.JPG`; `nullglob` drops non-matches
#   - works in macOS's bash 3.2 as well as newer bash
set -o errexit -o nounset -o pipefail
shopt -s extglob nullglob nocaseglob

workdir=$(mktemp -d "${TMPDIR:-/tmp}/mnemba-survey.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for photo in transect-1_0001.JPG transect-1_0002.JPG transect-1_0003_blurry.JPG \
             transect-2_0001.jpg transect-2_0002.jpeg transect-12_0001.JPG \
             turtle_hawksbill_0001.JPG briefing-map.png; do
  : > "$photo"
done

# region: alternation
# focus: *.@(jpg|jpeg)
photos=( *.@(jpg|jpeg) )
echo "dive photos, any extension spelling, any case: ${#photos[@]}"
# endregion: alternation

# region: one-or-more
# focus: transect-+([0-9])_*
echo "== transect photos (any transect number):"
printf '  %s\n' transect-+([0-9])_*
# endregion: one-or-more

# region: negation
# focus: transect-@(1|2)_!(*_blurry).@(jpg|jpeg)
echo "== transects 1 and 2, sharp only, for the coral cover count:"
printf '  %s\n' transect-@(1|2)_!(*_blurry).@(jpg|jpeg)
# endregion: negation

# region: empty-array
# focus: ${videos[@]+"${videos[@]}"}
videos=( *.@(mp4|mov) )
# bash 3.2 treats "${videos[@]}" on an empty array as unbound under set -u.
for clip in ${videos[@]+"${videos[@]}"}; do
  echo "clip: $clip"
done
echo "video clips this dive: ${#videos[@]}"
# endregion: empty-array
