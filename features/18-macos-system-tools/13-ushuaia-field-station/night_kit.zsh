#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 13 · Ushuaia field station night kit
#
# Teaches:
#   - `defaults write` records the logger id in a throwaway domain, deleted in the trap
#   - `caffeinate -t 1` covers the stamp step
#   - `mdls -name kMDItemFSName` confirms the sample on disk
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "night_kit.zsh uses macOS system tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ushuaia-station.XXXXXX")
domain=com.micharisma.multivitamin.ushuaia-night
trap 'defaults delete "$domain" 2>/dev/null || true; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir -p "$HOME/Library/Preferences" samples

# region: logger-pref
# focus: defaults write
defaults write $domain logger-id -string "beagle-canal-3"
print "logger: $(defaults read $domain logger-id)"
# endregion: logger-pref

# region: stamp-awake
# focus: caffeinate -t 1
caffeinate -t 1 &
print "sample canal-temp" > samples/canal-temp.txt
wait
print "stamp under caffeinate: done"
# endregion: stamp-awake

# region: mdls-sample
# focus: mdls
name=$(mdls -name kMDItemFSName -raw -- samples/canal-temp.txt)
print "sample fsname: $name"
# endregion: mdls-sample
