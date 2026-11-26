#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 10 · Ouagadougou radio prefs export/import
#
# Teaches:
#   - `defaults export domain file` snapshots every key to a plist
#   - `defaults delete` clears the domain before the restore drill
#   - `defaults import domain file` brings the snapshot back
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "prefs_roundtrip.zsh uses defaults, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ouaga-radio.XXXXXX")
domain=com.micharisma.multivitamin.ouaga-radio
trap 'defaults delete "$domain" 2>/dev/null || true; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir -p "$HOME/Library/Preferences"

defaults write $domain station -string "Radio La Voix"
defaults write $domain frequency -string "101.1"

# region: export-domain
# focus: defaults export
defaults export $domain radio-prefs.plist
print "exported: radio-prefs.plist"
# endregion: export-domain

defaults delete $domain
print "after delete, station missing: $(defaults read $domain station 2>/dev/null || print yes)"

# region: import-domain
# focus: defaults import
defaults import $domain radio-prefs.plist
print "restored station: $(defaults read $domain station)"
print "restored frequency: $(defaults read $domain frequency)"
# endregion: import-domain
