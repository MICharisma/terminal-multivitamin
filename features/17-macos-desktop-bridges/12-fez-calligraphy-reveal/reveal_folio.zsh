#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 12 · Fez calligraphy studio, revealing a folio
#
# Teaches:
#   - `open -R` reveals a file in a Finder window (guarded when headless)
#   - `osascript --` passes shell argv into `on run argv`
#   - AppleScript returns a caption string the studio pastes into the call notes
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "reveal_folio.zsh uses open and osascript, macOS tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fez-calligraphy.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p folios
print "thuluth study, gold on indigo, folio 14" > folios/thuluth-folio-14.txt

headless=0
[[ $TERM == dumb || ! -t 1 ]] && headless=1

folio=folios/thuluth-folio-14.txt

# region: reveal-finder
# focus: open -R
if (( headless )); then
  print "would: open -R -- $folio"
else
  open -R -- $folio
fi
print "revealed: ${folio:t}"
# endregion: reveal-finder

# region: osascript-argv
# focus: -- ${folio:t}
caption=$(osascript -e 'on run argv
  return "caption: " & item 1 of argv
end run' -- ${folio:t})
print "$caption"
# endregion: osascript-argv
