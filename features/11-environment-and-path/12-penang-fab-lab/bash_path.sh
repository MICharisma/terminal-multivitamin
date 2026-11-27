#!/usr/bin/env bash
# Environment and PATH · 12 · Penang fab lab, PATH and hashing in bash
#
# Teaches:
#   - bash has no tied `path` array: edit `PATH` as a string, then `hash -r`
#   - `hash` shows the cached locations; `hash -r` clears them after a PATH change
#   - `type -a` lists every match; `command -v` stays the portable one-liner
#   - works on macOS's bash 3.2 as well as newer bash
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fablab-penang.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p laser/bin cnc/bin
printf '#!/bin/sh\necho laser gcode 1.0\n' > laser/bin/gcode_send
printf '#!/bin/sh\necho cnc gcode 2.0\n' > cnc/bin/gcode_send
chmod +x laser/bin/gcode_send cnc/bin/gcode_send

# region: set-path
# focus: PATH="$workdir/laser/bin:/usr/bin:/bin"
PATH="$workdir/laser/bin:/usr/bin:/bin"
hash -r
echo "== laser first: $(gcode_send)"
# endregion: set-path

# region: hash-table
# focus: hash | grep -q gcode_send
gcode_send >/dev/null
echo "== bash hash table contains gcode_send after first run:"
if hash | grep -q gcode_send; then echo "  yes"; else echo "  no"; fi
# endregion: hash-table

# region: switch
# focus: hash -p
PATH="$workdir/cnc/bin:/usr/bin:/bin"
# Plant a stale hash entry pointing at laser while PATH says cnc.
hash -p "$workdir/laser/bin/gcode_send" gcode_send
echo "== PATH says cnc, hash still says laser: $(gcode_send)"
hash -r
echo "== after hash -r: $(gcode_send)"
# endregion: switch

# region: type-a
# focus: type -a gcode_send
PATH="$workdir/cnc/bin:$workdir/laser/bin:/usr/bin:/bin"
hash -r
echo "== type -a gcode_send:"
type -a gcode_send | sed "s|$workdir|WORK|; s/^/  /"
# endregion: type-a
