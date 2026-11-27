#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 01 · Bogotá agency shell aliases
#
# Teaches:
#   - `alias name=value` defines a shortcut expanded when `name` is a command word
#   - `alias -L` lists aliases as re-runnable `alias` statements
#   - `unalias` removes one when a campaign codename retires
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/bogota-agencia-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: define-aliases
# focus: alias
alias briefs='ls -1 campaigns/*/brief.md'
alias shoot='print "on set in Chapinero"'
# endregion: define-aliases

mkdir -p campaigns/cafe-nevado
print "storyboard for Cafe Nevado" > campaigns/cafe-nevado/brief.md

# region: list-aliases
# focus: alias -L
print "== agency aliases on this desk:"
alias -L briefs shoot
# endregion: list-aliases

# region: retire-alias
# focus: unalias
unalias shoot
if alias shoot >/dev/null 2>&1; then
  print "shoot still defined"
else
  print "shoot retired after the location wrap"
fi
print "briefs still works:"
briefs
# endregion: retire-alias
