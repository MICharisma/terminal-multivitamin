#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 09 · Split harbor watch with caffeinate -i
#
# Teaches:
#   - `caffeinate -i` prevents idle sleep while its child runs
#   - a background logger writes one tide line into the sandbox
#   - `wait` joins the assertion before the ledger prints
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "harbor_watch.zsh uses caffeinate, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/split-harbor.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: caffeinate-i
# focus: caffeinate -i
caffeinate -i zsh -c 'print "tide mark: +0.4m at riva berth 3" > tide-log.txt' &
wait
print "watch complete"
print "$(< tide-log.txt)"
# endregion: caffeinate-i
