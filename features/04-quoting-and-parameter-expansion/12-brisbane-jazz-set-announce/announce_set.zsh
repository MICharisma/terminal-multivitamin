#!/usr/bin/env zsh
# requires: macos
# Quoting and parameter expansion · 12 · Brisbane jazz club, announcing the next set
#
# Teaches:
#   - `${(q)line}` quotes a value so a generated script can type it back safely
#   - `${(qq)line}` always wraps in single quotes; use it when the result will be re-parsed
#   - a double-quoted AppleScript `-e "say \"$line\""` breaks when `$line` holds `"Bird"`;
#     escaping the embedded quotes fixes it
#   - `say -o file.aiff` writes audio without speaking aloud; `say` is macOS-only
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "announce_set.zsh uses say and osascript, which are macOS tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/jazz-club-fortitude.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

sets=(
  "Maeve O'Connor Quartet: Blue in Green"
  "The Fortitude Five: Take the A Train"
  'Linh "Bird" Nguyen Trio: Autumn Leaves'
)

# region: q-for-script
# focus: print -r -- "say -o ${(q)outfile} -- ${(q)line}"
print '#!/bin/zsh' > render.zsh
for i in {1..$#sets}; do
  line=$sets[i]
  outfile=set-$i.aiff
  print -r -- "say -o ${(q)outfile} -- ${(q)line}" >> render.zsh
done
print "== render.zsh, with (q) so a re-run parses each title as one word:"
sed 's/^/  /' render.zsh
# endregion: q-for-script

# region: qq-form
# focus: ${(qq)sets[3]}
print "same title with (qq), always single-quoted: ${(qq)sets[3]}"
# endregion: qq-form

# region: broken-applescript
# focus: osascript -e "say \"$line\""
line=$sets[3]
if ! osascript -e "say \"$line\"" 2>/dev/null; then
  print "AppleScript with raw double quotes: broke on \"Bird\""
fi
# endregion: broken-applescript

# region: escaped-applescript
# focus: escaped=${escaped//\"/\\\"}
escaped=${line//\\/\\\\}
escaped=${escaped//\"/\\\"}
osascript -e "say \"$escaped\"" > /dev/null
print "AppleScript with escaped quotes: announced $line"
# endregion: escaped-applescript

# region: render-all
# focus: zsh render.zsh
zsh render.zsh
aiffs=( *.aiff(N.on) )
print "aiff files ready for the interval playlist: ${#aiffs} (${(j:, :)aiffs})"
# endregion: render-all
