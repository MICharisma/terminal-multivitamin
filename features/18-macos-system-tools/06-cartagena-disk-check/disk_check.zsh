#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 06 · Cartagena library disk check
#
# Teaches:
#   - `diskutil info /` reads the boot volume (never erase, never partition)
#   - a `case` on the field name keeps only Mount Point (stable across machines)
#   - values are replaced with `present` so machines compare equal
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "disk_check.zsh uses diskutil, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cartagena-library.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: diskutil-info
# focus: diskutil info /
diskutil info / > disk-raw.txt
print "diskutil info / captured"
# endregion: diskutil-info

# region: case-fields
# focus: case $field in
setopt extended_glob
print "== boot volume fields:"
while IFS= read -r line; do
  field=${${line%%:*}##[[:space:]]##}
  field=${field%%[[:space:]]##}
  case $field in
    ("Mount Point")
      print "Mount Point: present"
      ;;
  esac
done < disk-raw.txt
# endregion: case-fields
