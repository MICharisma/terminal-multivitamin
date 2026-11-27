#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 01 · Quito family photo album, revealing a roll in Finder
#
# Teaches:
#   - `open` hands a folder or file to Finder / Preview without leaving Terminal
#   - under a headless `TERM` (the test runner), print what would run instead of opening a GUI
#   - `open` on a folder focuses Finder; on a note it opens the default text app
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "reveal_album.zsh uses open, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/familia-quispe-album.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p roll-2026-carnaval
print "IMG_1042: plaza San Francisco, confetti on the cobbles" > roll-2026-carnaval/img_1042-plaza.txt
print "IMG_1048: abuela Elena with the banda" > roll-2026-carnaval/img_1048-abuela.txt

headless=0
[[ $TERM == dumb || ! -t 1 ]] && headless=1

run_open() {
  if (( headless )); then
    print "would: open $*"
  else
    open "$@"
  fi
}

# region: open-folder
# focus: open roll-2026-carnaval
run_open roll-2026-carnaval
print "album folder: roll-2026-carnaval"
# endregion: open-folder

# region: open-photo
# focus: open roll-2026-carnaval/img_1042-plaza.txt
run_open roll-2026-carnaval/img_1042-plaza.txt
print "opened note: img_1042-plaza.txt"
# endregion: open-photo

# region: headless-guard
# focus: headless
print "headless guard: $( (( headless )) && print on || print off )"
# endregion: headless-guard
