#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 02 · Colombo tea auction clipboard for the lot board
#
# Teaches:
#   - `print -n ... | pbcopy` puts text on the macOS pasteboard
#   - `pbpaste` reads it back; redirect into a board file for the auctioneer
#   - a second copy replaces the first; the pasteboard holds one thing at a time
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "lot_clipboard.zsh uses pbcopy/pbpaste, macOS pasteboard tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/colombo-tea-auction.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

lot_line="lot-2184 uva OP1 1.2kg  Rs 1840/kg"

# region: copy-lot
# focus: pbcopy
print -n -- "$lot_line" | pbcopy
print "copied lot line to pasteboard"
# endregion: copy-lot

# region: paste-board
# focus: pbpaste
pbpaste > lot-board.txt
print "board file: $(< lot-board.txt)"
# endregion: paste-board

# region: replace-clip
# focus: lot-2185 nuwara-eliya
print -n -- "lot-2185 nuwara-eliya BOPF 0.8kg  Rs 1920/kg" | pbcopy
print "pasteboard now: $(pbpaste)"
# endregion: replace-clip
