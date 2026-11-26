#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 11 · Cebu school handout metadata
#
# Teaches:
#   - process substitution builds the handout path list
#   - `mdls -raw -name kMDItemFSName` prints only the value, no key prefix
#   - a for-loop over the substituted list keeps the ledger tidy
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "handout_names.zsh uses mdls, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cebu-handouts.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p handouts
print "volcanoes of the Visayas" > handouts/visayas-volcanoes.txt
print "coral survey worksheet" > handouts/coral-worksheet.txt

# region: process-list
# focus: <(
list=<(print -l handouts/*.txt)
# endregion: process-list

# region: mdls-raw
# focus: mdls -raw
print "== handout FS names:"
while IFS= read -r handout; do
  print "$(mdls -raw -name kMDItemFSName -- $handout)"
done < $list | sort
# endregion: mdls-raw
