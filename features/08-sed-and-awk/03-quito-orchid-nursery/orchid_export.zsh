#!/usr/bin/env zsh
# Editing streams with sed and awk · 03 · Quito orchid nursery export
#
# Teaches:
#   - `sed -n 'p'` prints only the lines that survive earlier commands in the script
#   - `sed '/pattern/d'` deletes matching lines from the stream
#   - `sed '/pattern/!p'` inverts the match so non-matching lines print
#   - `sed 'Nq'` quits after line N, handy for a quick header peek
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/quito-orchids.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/nursery-export.txt .

# region: quiet-print
# focus: sed -n '1,3p'
print "== first three rows for the customs broker:"
sed -n '1,3p' nursery-export.txt
# endregion: quiet-print

# region: delete-draft
# focus: sed '/^draft /d'
print "== drop draft lots before invoicing:"
sed '/^draft /d' nursery-export.txt
print
# endregion: delete-draft

# region: invert
# focus: sed -n '/^shipped /!p'
print "== lots not yet on the truck:"
while IFS= read -r line; do
  sed -n '/^shipped /!p' <<< "$line"
done < nursery-export.txt
print
# endregion: invert

# region: quit-early
# focus: sed -n '5{p;q;}'
print "== stop after the fifth line for a fax cover sheet:"
sed -n '5{p;q;}' nursery-export.txt
# endregion: quit-early