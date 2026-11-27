#!/usr/bin/env zsh
# Homebrew · 03 · Porto family laptop formula cards
#
# Teaches:
#   - `brew info --json=v1 FORMULA` prints a machine-readable card for one formula
#   - the JSON array's first object holds `name`, `desc`, and `versions.stable`
#   - parsing with Python keeps the lesson free of a `jq` dependency
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/familia-oliveira-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: info-json
# focus: brew info --json=v1 ffmpeg
card=$(brew info --json=v1 ffmpeg)
# endregion: info-json

# region: extract-fields
# focus: formula["versions"]
print "$card" | python3 -c '
import json, sys
formula = json.load(sys.stdin)[0]
print("name:    " + formula["name"])
print("desc:    " + formula["desc"])
print("stable:  " + formula["versions"]["stable"])
print("keg-only:" + str(formula["keg_only"]).lower())
'
# endregion: extract-fields
