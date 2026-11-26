#!/usr/bin/env zsh
# Navigation and files · 06 · Accra outdooring photos from a cousin's phone
#
# Teaches:
#   - cp -p keeps the original timestamps on a safety copy before renaming
#   - a tab-separated rename plan read with `while IFS=$'\t' read -r`
#   - mv -n never overwrites; checking [[ -e ]] first lets the script say why
#   - `--` stops a filename from being read as an option
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/outdooring-akosua.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"

# region: keep-originals
# focus: cp -p -- phone-import/*.JPG originals/
mkdir originals
cp -p -- phone-import/*.JPG originals/
print "safety copies: $(ls originals | wc -l | tr -d ' ')"
# endregion: keep-originals

# region: read-plan
# focus: while IFS=$'\t' read -r old new
cd phone-import
while IFS=$'\t' read -r old new; do
  # endregion: read-plan
  # region: guarded-move
  # focus: mv -n -- $old $new
  if [[ ! -e $old ]]; then
    print "missing: $old (not on this phone)"
  elif [[ -e $new ]]; then
    print "kept:    $new already exists, $old left as it is"
  else
    mv -n -- $old $new
    print "renamed: $old -> $new"
  fi
  # endregion: guarded-move
done < ../renames.tsv

# region: show-album
# focus: ls -1
print "== album folder now:"
ls -1
# endregion: show-album
