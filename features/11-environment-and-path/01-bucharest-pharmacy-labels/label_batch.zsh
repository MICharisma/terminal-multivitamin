#!/usr/bin/env zsh
# Environment and PATH · 01 · Bucharest pharmacy, exporting the batch number for every label printer
#
# Teaches:
#   - a plain assignment is local to the shell; `export` puts it in the environment children inherit
#   - `printenv NAME` reads the environment; `print $NAME` reads the shell variable (usually the same)
#   - `export -p` lists export flags; `unset` removes both the shell variable and the environment entry
#   - a child started without the export does not see the value
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/farmacia-radu.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
if [[ -n ${BATCH_NO-} ]]; then
  print "label batch $BATCH_NO for $1"
else
  print "no batch number for $1"
fi' > print_label.zsh
chmod +x print_label.zsh

# region: plain-assign
# focus: BATCH_NO=2026-11-26-A
BATCH_NO=2026-11-26-A
print "== shell sees BATCH_NO=$BATCH_NO"
print "  child without export: $(./print_label.zsh amoxicillin)"
# endregion: plain-assign

# region: export
# focus: export BATCH_NO
export BATCH_NO
print "== after export:"
print "  child: $(./print_label.zsh amoxicillin)"
print "  printenv: $(printenv BATCH_NO)"
# endregion: export

# region: export-p
# focus: export -p
print "== export -p (just our batch):"
export -p | grep BATCH_NO | sed 's/^/  /'
# endregion: export-p

# region: unset
# focus: unset BATCH_NO
unset BATCH_NO
print "== after unset:"
if printenv BATCH_NO >/dev/null; then print "  still set"; else print "  printenv finds nothing"; fi
print "  child: $(./print_label.zsh ibuprofen)"
# endregion: unset
