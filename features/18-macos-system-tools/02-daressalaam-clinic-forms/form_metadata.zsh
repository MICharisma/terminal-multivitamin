#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 02 · Dar es Salaam clinic forms, reading Spotlight metadata
#
# Teaches:
#   - `for form in intake/*.txt` walks every form once
#   - `mdls -name kMDItemFSName -name kMDItemFSSize` prints selected attributes
#   - relative names stay in the ledger; absolute temp paths never do
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "form_metadata.zsh uses mdls, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dar-clinic.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p intake
print "patient: Amina Juma; fever clinic" > intake/amina-juma.txt
print "patient: Baraka Mwinyi; follow-up" > intake/baraka-mwinyi.txt

# region: loop-forms
# focus: for form in intake/*.txt
print "== intake metadata:"
for form in intake/*.txt; do
  # endregion: loop-forms
  # region: mdls-names
  # focus: mdls -name
  fsname=$(mdls -name kMDItemFSName -raw -- $form)
  # size can vary with newline; compare presence only via mdls exit
  mdls -name kMDItemFSSize -- $form >/dev/null
  print "${form:t} fsname=$fsname size=present"
  # endregion: mdls-names
done
