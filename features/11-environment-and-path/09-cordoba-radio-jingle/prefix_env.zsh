#!/usr/bin/env zsh
# Environment and PATH · 09 · Córdoba community radio, one-shot environment on the jingle command
#
# Teaches:
#   - `NAME=value command` sets the variable only for that command's environment
#   - the shell's own `NAME` is unchanged afterwards
#   - several assignments may precede the command: `A=1 B=2 cmd`
#   - this is the lightest way to hand a config to one helper without `export`/`unset`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/radio-universidad.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
print "jingle station=$STATION bed=$BED_DB"' > play_jingle.zsh
chmod +x play_jingle.zsh

STATION=default
BED_DB=studio

# region: prefix
# focus: STATION=Radio-Universidad BED_DB=cumbia ./play_jingle.zsh
print "== one-shot for the evening bed:"
STATION=Radio-Universidad BED_DB=cumbia ./play_jingle.zsh | sed 's/^/  /'
# endregion: prefix

# region: shell-unchanged
# focus: shell still STATION=$STATION
print "== shell still STATION=$STATION BED_DB=$BED_DB"
# endregion: shell-unchanged

# region: default-run
# focus: ./play_jingle.zsh
export STATION BED_DB
print "== after export, defaults reach the child:"
./play_jingle.zsh | sed 's/^/  /'
# endregion: default-run
