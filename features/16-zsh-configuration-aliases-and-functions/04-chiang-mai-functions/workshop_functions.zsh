#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 04 · Chiang Mai lacquer workshop functions
#
# Teaches:
#   - `function name { ... }` (or `name()`) defines a function with its own arguments
#   - `typeset -f name` prints the definition, useful when teaching apprentices
#   - functions beat aliases when you need arguments, locals, or more than one command
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/chiang-mai-lacquer-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p trays/{raw,sealed}
print "tray 14, teak" > trays/raw/tray-14.txt
print "tray 15, bamboo" > trays/raw/tray-15.txt

# region: define-fn
# focus: function
function seal_tray {
  local tray=$1
  mv -- trays/raw/$tray trays/sealed/$tray
  print "sealed $tray"
}
# endregion: define-fn

# region: show-fn
# focus: typeset -f
print "== apprentice handout:"
typeset -f seal_tray
# endregion: show-fn

# region: call-fn
# focus: seal_tray tray-14.txt
seal_tray tray-14.txt
print "== sealed trays:"
print -l trays/sealed/*
# endregion: call-fn
