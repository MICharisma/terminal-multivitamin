#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 06 · Lyon bicycle cooperative local options
#
# Teaches:
#   - `emulate -L zsh` resets options to a known zsh baseline inside a function
#   - `setopt local_options` makes later `setopt`/`unsetopt` revert when the function returns
#   - the cooperative's null_glob stays local so the caller's options are unchanged
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/lyon-velo-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p bikes
print "frame geometry" > bikes/randonneur-52.txt
setopt nomatch

# region: local-fn
# focus: setopt local_options
list_spares() {
  emulate -L zsh
  setopt local_options null_glob
  local parts=( bikes/*.spare )
  if (( $#parts )); then
    print -l $parts
  else
    print "no .spare files on the rack"
  fi
}
# endregion: local-fn

# region: caller-options
# focus: list_spares
print "== inside the function (null_glob local):"
list_spares
print "== caller still has nomatch: $([[ -o nomatch ]] && print yes || print no)"
print "== unmatched glob still errors for the caller:"
if ( parts=( bikes/*.spare ) ) 2>/dev/null; then
  print "unexpected match"
else
  print "nomatch rejected bikes/*.spare"
fi
# endregion: caller-options
