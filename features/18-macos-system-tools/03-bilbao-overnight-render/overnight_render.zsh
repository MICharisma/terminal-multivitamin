#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 03 · Bilbao overnight render under caffeinate
#
# Teaches:
#   - `emulate -L zsh` keeps the render helper's options local
#   - `caffeinate -t 2` asserts user idle sleep for two seconds
#   - the render stand-in runs under that assertion and writes one frame mark
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "overnight_render.zsh uses caffeinate, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/bilbao-render.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir -p frames

# region: local-render
# focus: emulate -L zsh
write_frame() {
  emulate -L zsh
  setopt local_options
  local mark=$1
  print "frame $mark ok" > frames/frame-$mark.txt
}
# endregion: local-render

# region: caffeinate-t
# focus: caffeinate -t 2
caffeinate -t 2 &
cafe_pid=$!
write_frame 0001
wait $cafe_pid
print "caffeinate -t finished"
print "frame: $(< frames/frame-0001.txt)"
# endregion: caffeinate-t
