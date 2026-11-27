#!/usr/bin/env zsh
# Navigation and files · 10 · Tbilisi film archive, mirroring digitized reels
#
# Teaches:
#   - `cp -R src/` behaves differently on macOS (BSD copies the contents) and
#     Linux (GNU copies the folder); `cp -R src/. dest/` means the same on both
#   - `cp -Rp` keeps modification times, so the mirror sorts like the original
#   - `diff -r` compares two trees and exits 0 when they match
#   - `du -sk` totals each film folder in kilobytes for a largest-first list
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kinoarkivi.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -A reel_kib=(
  pirosmani-1969/reel-1  96
  pirosmani-1969/reel-2  64
  giorgobistve-1966/reel-1 224
  repentance-1984/reel-1 48
)
for reel kib in ${(kv)reel_kib}; do
  mkdir -p scans/$reel
  head -c $(( kib * 1024 )) /dev/zero > scans/$reel/frames.dpx
  print "scanned at 4K, Georgian National Film Center, Nov 2026" > scans/$reel/notes.txt
  touch -t 202611200930 scans/$reel/frames.dpx scans/$reel/notes.txt
done

# region: mirror-contents
# focus: cp -Rp scans/. mirror/scans/
mkdir -p mirror/scans
cp -Rp scans/. mirror/scans/
print "== mirror/scans holds the films themselves, not a nested scans/ folder:"
ls -1 mirror/scans
# endregion: mirror-contents

# region: compare-trees
# focus: diff -r scans mirror/scans
if diff -r scans mirror/scans >/dev/null; then
  print "diff -r: mirror matches the scans"
fi
if [[ ! mirror/scans/giorgobistve-1966/reel-1/frames.dpx -nt scans/giorgobistve-1966/reel-1/frames.dpx ]]; then
  print "cp -p kept the scan time on frames.dpx"
fi
# endregion: compare-trees

# region: largest-films
# focus: du -sk scans/*
print "== films by size on disk, largest first:"
du -sk scans/* | sort -rn | while read -r kib film; do
  print "  ${film:t}"
done
# endregion: largest-films

# region: catch-drift
# focus: diff -r scans mirror/scans
print "re-graded" >> scans/repentance-1984/reel-1/notes.txt
if ! diff -r scans mirror/scans >/dev/null; then
  print "diff -r: mirror is stale after the re-grade of repentance-1984"
fi
# endregion: catch-drift
