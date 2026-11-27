#!/usr/bin/env zsh
# Sorting, counting, and columns · 08 · Oslo museum accession, reconciling photo day with the register
#
# Teaches:
#   - `comm` compares two sorted line lists and only works when both inputs are ordered
#   - `comm -23` prints lines only in the first file (accessioned but not photographed)
#   - `comm -13` prints lines only in the second file (photographed before paperwork)
#   - `comm -12` prints lines in both files (ready for the website)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/munch-museum.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/{accessioned.txt,photographed.txt} $workdir/
cd -- "$workdir"

typeset -a only_first only_second both
only_first=()
only_second=()
both=()

# region: comm-only-first
# focus: comm -23 accessioned.txt photographed.txt
only_first=(${(f)"$(comm -23 accessioned.txt photographed.txt)"})
print "== accessioned, not yet photographed: ${(j:, :)only_first}"
# endregion: comm-only-first

# region: comm-only-second
# focus: comm -13 accessioned.txt photographed.txt
only_second=(${(f)"$(comm -13 accessioned.txt photographed.txt)"})
print "== photographed before paperwork: ${(j:, :)only_second}"
# endregion: comm-only-second

# region: comm-both
# focus: comm -12 accessioned.txt photographed.txt
both=(${(f)"$(comm -12 accessioned.txt photographed.txt)"})
print "== ready for the online catalogue (${#both[@]} items):"
for id in $both; do
  print "  $id"
done
# endregion: comm-both