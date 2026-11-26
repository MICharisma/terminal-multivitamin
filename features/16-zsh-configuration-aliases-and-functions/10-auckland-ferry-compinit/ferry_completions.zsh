#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 10 · Auckland ferry completions
#
# Teaches:
#   - `compinit` loads zsh's completion system from directories on `fpath`
#   - a custom completion function named `_command` lives in a directory on `fpath`
#   - after `compinit`, `whence -v _schedule` shows the completion helper is available
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/auckland-ferry-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p completions
cat > completions/_schedule <<'FN'
#compdef schedule
local -a runs
runs=( devonport bayswater birkenhead )
_describe 'ferry run' runs
FN

# region: fpath-completions
# focus: fpath
fpath=( $workdir/completions $fpath )
# endregion: fpath-completions

# region: compinit
# focus: compinit
autoload -Uz compinit
compinit -d $workdir/.zcompdump
# endregion: compinit

# region: verify
# focus: whence -v _schedule
print "== completion helper for schedule:"
whence_line=$(whence -v _schedule)
print "${whence_line/$workdir\//}"
print "== dump written beside the temp config: .zcompdump ($([[ -f $workdir/.zcompdump ]] && print present || print missing))"
# endregion: verify
