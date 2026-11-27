#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 03 · Antwerp diamond atelier contact sheets
#
# Teaches:
#   - `for stone in stones/*.png` walks every still once
#   - `sips -Z 64` fits the long side to 64 pixels into a contact sheet copy
#   - `sips -g pixelWidth` reads the width so the ledger can record it
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "contact_sheets.zsh uses sips, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/antwerp-atelier.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p stones contacts
cp -- ${0:A:h}/fixtures/stone-round.png stones/stone-round.png
cp -- ${0:A:h}/fixtures/stone-pear.png stones/stone-pear.png

# region: loop-stones
# focus: for stone in stones/*.png
print "== contact tiles:"
for stone in stones/*.png; do
  # endregion: loop-stones
  # region: resize
  # focus: sips -Z 64
  # sips has no GNU `--`; paths come after the options.
  tile=contacts/${stone:t:r}-tile.png
  sips -Z 64 --out $tile $stone >/dev/null
  # endregion: resize
  # region: read-width
  # focus: sips -g pixelWidth
  width=$(sips -g pixelWidth $tile | awk '/pixelWidth/{print $2}')
  print "${tile:t} width=$width"
  # endregion: read-width
done
