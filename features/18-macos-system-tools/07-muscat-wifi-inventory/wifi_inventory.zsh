#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 07 · Muscat hotel Wi-Fi inventory
#
# Teaches:
#   - `networksetup -listallhardwareports` lists ports (read-only)
#   - `while IFS= read -r` walks each line of the inventory
#   - the ledger only records whether a Device line appeared
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "wifi_inventory.zsh uses networksetup, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/muscat-hotel.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: list-ports
# focus: networksetup -listallhardwareports
networksetup -listallhardwareports > ports-raw.txt
print "hardware ports captured"
# endregion: list-ports

# region: read-devices
# focus: while IFS= read -r
found=no
while IFS= read -r line; do
  if [[ $line == Device:* ]]; then
    found=yes
    break
  fi
done < ports-raw.txt
print "device line present: $found"
# endregion: read-devices
