#!/usr/bin/env zsh
# Archives and compression · 11 · Medellín gallery unzip
#
# Teaches:
#   - `unzip -Z1` lists zip members by name only (no date columns that drift)
#   - `unzip archive member` extracts one file; a `case` picks which print to hang
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/medellin-gallery.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p exhibition
print "Botero-inspired bronze study, plaza" > exhibition/bronze-plaza.jpg
print "Comuna 13 mural detail, stairs"      > exhibition/mural-stairs.jpg
print "Guatapé boat reflection, midday"     > exhibition/guatape-boat.jpg
zip -r exhibition.zip exhibition >/dev/null
rm -rf exhibition

# region: list-names
# focus: unzip -Z1 exhibition.zip
print "== exhibition.zip members:"
unzip -Z1 exhibition.zip | sort
# endregion: list-names

wanted=mural

# region: pick-member
# focus: case $wanted in
case $wanted in
  bronze)  member=exhibition/bronze-plaza.jpg ;;
  mural)   member=exhibition/mural-stairs.jpg ;;
  guatape) member=exhibition/guatape-boat.jpg ;;
  *)       print -u2 "unknown print: $wanted"; exit 1 ;;
esac
print "== hanging ${member:t}"
# endregion: pick-member

# region: extract-one
# focus: unzip -q exhibition.zip $member
mkdir -p wall
unzip -q exhibition.zip $member -d wall
print "== on the wall:"
print "  $(< wall/$member)"
# endregion: extract-one
