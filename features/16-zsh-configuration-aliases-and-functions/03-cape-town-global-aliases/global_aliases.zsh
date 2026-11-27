#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 03 · Cape Town family global aliases
#
# Teaches:
#   - `alias -g NAME=value` expands `NAME` anywhere in the command line, not only as argv0
#   - global aliases are handy for repeated redirections and pager tails in a family archive
#   - quote carefully: a global alias is a sharp tool
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cape-town-family-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p album/2026-heritage
print "oma at the castle" > album/2026-heritage/castles.txt
print "braai names" > album/2026-heritage/braai.txt

# region: global-alias
# focus: alias -g
alias -g COUNT='| wc -l | tr -d " "'
alias -g NAMES='album/2026-heritage/*.txt'
# endregion: global-alias

# region: use-global
# focus: print -l NAMES
print "== files in the heritage album:"
print -l NAMES
print "== line count across the album:"
cat NAMES COUNT
# endregion: use-global
