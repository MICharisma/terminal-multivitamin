#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 04 · Belfast radio rundown, converting the cue sheet
#
# Teaches:
#   - `while IFS= read -r` walks a two-column convert plan
#   - `textutil -convert rtf -output ...` writes an RTF the on-air Mac can open
#   - the plan keeps source and destination names explicit, no guessing extensions
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "convert_rundown.zsh uses textutil, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/belfast-rundown.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p cues rtf
print "19:00  news bed — Stormont brief" > cues/1900-news.txt
print "19:08  live: Orla on Donegall Place" > cues/1908-orla.txt
print "cues/1900-news.txt rtf/1900-news.rtf\ncues/1908-orla.txt rtf/1908-orla.rtf" > convert.plan

# region: read-plan
# focus: while IFS= read -r src dest
while IFS= read -r src dest; do
  # endregion: read-plan
  # region: convert
  # focus: textutil -convert rtf
  textutil -convert rtf -output $dest -- $src
  print "converted ${src:t} -> ${dest:t}"
  # endregion: convert
done < convert.plan

print "== rtf desk:"
ls -1 rtf
