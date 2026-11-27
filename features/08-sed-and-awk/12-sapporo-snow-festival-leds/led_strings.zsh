#!/usr/bin/env zsh
# requires: macos
# Editing streams with sed and awk · 12 · Sapporo snow festival LEDs
#
# Teaches:
#   - on macOS, BSD `sed -i '' 'cmd' file` edits in place with no backup file
#   - GNU `sed -i 'cmd'` needs no empty argument; this slot stays on BSD intentionally
#   - patching channel names in place is safer with a dry run through bare `sed` first
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "led_strings.zsh uses BSD sed -i '' with no backup, which is macOS syntax"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/odori-leds.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/ice-sculpture-map.txt map.txt

# region: dry-run
# focus: sed 's/channel BLUE/channel ICE-BLUE/g'
print "== planned rename on stdout:"
sed 's/channel BLUE/channel ICE-BLUE/g' map.txt
# endregion: dry-run

# region: bsd-inplace
# focus: sed -i '' 's/channel BLUE/channel ICE-BLUE/g'
cp map.txt map-backup.txt
sed -i '' 's/channel BLUE/channel ICE-BLUE/g' map.txt
print "== file on disk after BSD -i '':"
print -r -- "$(<map.txt)"
print "  .bak sibling: $([[ -e map.txt.bak ]] && print yes || print no)"
# endregion: bsd-inplace

# region: second-pass
# focus: sed -i '' 's/channel RED/channel AURORA/g'
sed -i '' 's/channel RED/channel AURORA/g' map.txt
print "== both channels retuned for the snowpack glare:"
grep channel map.txt | sort
# endregion: second-pass