#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 05 · Kampala school bulletin via AppleScript
#
# Teaches:
#   - `emulate -L zsh` plus `setopt local_options` keeps the helper's options local
#   - `osascript -e` runs a one-liner that joins class names with commas
#   - the function returns AppleScript's result into a shell variable
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "bulletin_title.zsh uses osascript, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/nakasero-bulletin.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: local-helper
# focus: emulate -L zsh
join_classes() {
  emulate -L zsh
  setopt local_options
  local applescript
  applescript='on run argv
    set AppleScript'\''s text item delimiters to ", "
    return argv as text
  end run'
  # endregion: local-helper
  # region: osascript-join
  # focus: osascript -e
  osascript -e "$applescript" -- "$@"
  # endregion: osascript-join
}

title=$(join_classes "P.4 Sunflower" "P.5 Jacaranda" "P.6 Mvule")
print "bulletin title: Friday notes — $title"
print "classes counted: 3"
