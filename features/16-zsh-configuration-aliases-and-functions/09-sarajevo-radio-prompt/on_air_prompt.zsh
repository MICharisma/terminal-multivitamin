#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 09 · Sarajevo radio prompt
#
# Teaches:
#   - `PROMPT` is the left prompt string, expanded with prompt escapes each time it prints
#   - `RPROMPT` sits on the right edge for glanceable status (studio, on-air flag)
#   - `print -P` expands prompt escapes without waiting for a real prompt draw
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sarajevo-radio-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

studio=studio-b
on_air=1

# region: set-prompt
# focus: PROMPT
PROMPT="%F{cyan}eR-${studio}%f %# "
# endregion: set-prompt

# region: set-rprompt
# focus: RPROMPT
if (( on_air )); then
  RPROMPT="%F{red}ON AIR%f"
else
  RPROMPT="%F{green}off%f"
fi
# endregion: set-rprompt

# region: preview
# focus: print -P
print "== preview with print -P:"
print -P "LEFT:  ${PROMPT}"
print -P "RIGHT: ${RPROMPT}"
# endregion: preview
