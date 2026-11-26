#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 11 · Cebu school handout metadata
#
# Teaches:
#   - process substitution builds the handout path list
#   - `mdls -raw -name kMDItemFSName` prints only the value, no key prefix
#   - consume `<(...)` immediately; a stored /dev/fd goes stale
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
# Materialize the list right away so the fd is not reused after it closes.
cat < <(print -l handouts/*.txt) > handout-paths.txt
# endregion: process-list

# region: mdls-raw
# focus: mdls -raw
print "== handout FS names:"
while IFS= read -r handout; do
  print "$(mdls -raw -name kMDItemFSName -- $handout)"
done < handout-paths.txt | sort
# endregion: mdls-raw
