#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 05 · Vienna chamber orchestra autoload
#
# Teaches:
#   - `fpath` is the list of directories where `autoload` looks for function files
#   - `autoload -Uz name` marks `name` to load from `$fpath` on first call
#   - one file per function keeps the orchestra's cue helpers modular
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/vienna-chamber-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p zfunctions scores
print "Mozart K.458, rehearsal letter B" > scores/k458-letter-b.txt

# region: fpath-setup
# focus: fpath
cat > zfunctions/cue_letter <<'FN'
print "cue: rehearsal letter ${1:-A} — strings ready"
FN
fpath=( $workdir/zfunctions $fpath )
# endregion: fpath-setup

# region: autoload
# focus: autoload -Uz
autoload -Uz cue_letter
# endregion: autoload

# region: first-call
# focus: cue_letter B
cue_letter B
print "function file still on disk: zfunctions/cue_letter"
# endregion: first-call
