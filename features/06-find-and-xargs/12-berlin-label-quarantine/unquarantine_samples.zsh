#!/usr/bin/env zsh
# requires: macos
# Finding files with find and xargs · 12 · Berlin techno label, clearing quarantine from sample packs
#
# Teaches:
#   - files downloaded on a Mac carry a `com.apple.quarantine` extended attribute
#   - macOS `find` can test extended attributes with `-xattrname name` (and `-xattr` for any);
#     GNU `find` has no such tests
#   - `find ... -xattrname com.apple.quarantine -print0 | xargs -0 xattr -d com.apple.quarantine`
#     removes that one attribute and leaves the label's own tags alone
#   - `xattr -cr` clears every attribute in a tree, tags included
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "unquarantine_samples.zsh uses find -xattrname and xattr, which are macOS tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kellerton-samples.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p samples/{kick-drums,"hi hats",pads}
for sample in kick-drums/rumble-kick-128.wav kick-drums/909-kick-tuned.wav \
              "hi hats/open hat 03.wav" pads/spree-dawn-pad.wav pads/tresor-drone.wav; do
  print "24-bit WAV sample, Kellerton Records pack vol. 4" > samples/$sample
done
for downloaded in samples/kick-drums/*.wav "samples/hi hats/open hat 03.wav" samples/pads/tresor-drone.wav; do
  xattr -w com.apple.quarantine "0083;6744a1c0;Safari;" $downloaded
done
xattr -w de.kellerton.bpm 128 samples/kick-drums/rumble-kick-128.wav
xattr -w de.kellerton.bpm 124 samples/pads/spree-dawn-pad.wav

# region: find-quarantined
# focus: find samples -type f -xattrname com.apple.quarantine
print "== still quarantined, Ableton will ask about each one:"
find samples -type f -xattrname com.apple.quarantine | sort
# endregion: find-quarantined

# region: find-tagged
# focus: -xattrname de.kellerton.bpm
print "== tagged with a BPM by the label:"
find samples -type f -xattrname de.kellerton.bpm | sort
# endregion: find-tagged

# region: clear-quarantine
# focus: xargs -0 xattr -d com.apple.quarantine
cp -R samples samples-backup
find samples -type f -xattrname com.apple.quarantine -print0 | xargs -0 xattr -d com.apple.quarantine
print "quarantined after xattr -d: $(find samples -xattrname com.apple.quarantine | wc -l | tr -d ' ')"
print "BPM tag kept on rumble-kick-128.wav: $(xattr -p de.kellerton.bpm samples/kick-drums/rumble-kick-128.wav)"
# endregion: clear-quarantine

# region: clear-everything
# focus: xattr -cr samples-backup
xattr -cr samples-backup
print "after xattr -cr on the backup, BPM tags left: $(find samples-backup -xattrname de.kellerton.bpm | wc -l | tr -d ' ')"
# endregion: clear-everything
