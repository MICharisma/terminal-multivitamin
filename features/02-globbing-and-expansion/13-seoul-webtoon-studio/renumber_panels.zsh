#!/usr/bin/env zsh
# Globbing and expansion · 13 · Seoul webtoon studio, renumbering exported panels
#
# Teaches:
#   - `zmv` renames by pattern; `(...)` in the source becomes `$1`, `$2` in the target
#   - `zmv -n` prints the plan without touching anything
#   - `zmv` refuses the whole batch when two files would land on one name
#   - `${(l:3::0:)1}` pads a capture with zeros on the left
#   - `zmv -W` uses plain `*` on both sides, here to move files into folders
#     named with `${(u)...}` from the matches themselves
set -o errexit -o nounset -o pipefail
autoload -Uz zmv
setopt extended_glob

workdir=$(mktemp -d "${TMPDIR:-/tmp}/webtoon-haneul.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# Exports from three artists' tablets, each with its own idea of capitals and padding.
for panel in ep3_panel1.png ep3_panel2.png ep3_panel10.png EP12_Panel1.PNG EP12_Panel2.PNG \
             ep12_panel3.png ep3_panel02.png; do
  print "panel art for ${panel}" > $panel
done

# region: refuse-collision
# focus: zmv '(#i)ep(<->)_panel(<->).png' 'ep${(l:3::0:)1}-panel${(l:2::0:)2}.png'
if ! zmv '(#i)ep(<->)_panel(<->).png' 'ep${(l:3::0:)1}-panel${(l:2::0:)2}.png' 2>/dev/null; then
  print "zmv refused: ep3_panel2 and ep3_panel02 would both become ep003-panel02.png"
  print "nothing moved: $(print -l *(.) | wc -l | tr -d ' ') files still under their export names"
fi
mkdir duplicates
mv -- ep3_panel02.png duplicates/
# endregion: refuse-collision

# region: dry-run
# focus: zmv -n
print "== dry run:"
zmv -n '(#i)ep(<->)_panel(<->).png' 'ep${(l:3::0:)1}-panel${(l:2::0:)2}.png'
# endregion: dry-run

# region: rename
# focus: zmv '(#i)ep(<->)_panel(<->).png' 'ep${(l:3::0:)1}-panel${(l:2::0:)2}.png'
zmv '(#i)ep(<->)_panel(<->).png' 'ep${(l:3::0:)1}-panel${(l:2::0:)2}.png'
print "== renamed:"
print -l *.png
# endregion: rename

# region: into-folders
# focus: zmv -W 'ep*-panel*.png' 'ep*/panel*.png'
panels=( ep<->-panel<->.png )
mkdir -p ${(u)panels%%-*}
zmv -W 'ep*-panel*.png' 'ep*/panel*.png'
print "== episode folders for the upload to the platform:"
for episode in ep<->(/); do
  episode_panels=( $episode/*(:t) )
  print "$episode: $episode_panels"
done
# endregion: into-folders
