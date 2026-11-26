#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 08 · Valletta maritime museum wall-label captures
#
# Teaches:
#   - an array of capture specs drives the shot list
#   - `screencapture -x -o` would save silently without shutter sound or shadow
#   - headless mode prints the full command instead of touching the display
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "label_captures.zsh uses screencapture, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/valletta-labels.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p shots
typeset -a plan
plan=(
  "gallery-a:shots/gallery-a-label.png"
  "gallery-b:shots/gallery-b-label.png"
)

headless=0
[[ $TERM == dumb || ! -t 1 ]] && headless=1

# Always dry on CI: screencapture needs Screen Recording permission.
# region: build-capture
# focus: screencapture -x -o
for spec in $plan; do
  label=${spec%%:*}
  dest=${spec#*:}
  cmd=(screencapture -x -o -- $dest)
  # endregion: build-capture
  # region: guard-capture
  # focus: headless
  if (( headless )); then
    print "would: screencapture -x -o -- $dest  # $label"
  else
    print "interactive capture skipped in catalog; use: screencapture -x -o -- $dest"
  fi
  print "planned: $label"
  # endregion: guard-capture
done
