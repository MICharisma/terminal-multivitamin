#!/usr/bin/env zsh
# Sorting, counting, and columns · 05 · Bangkok street food, cleaning the vendor sign board
#
# Teaches:
#   - `tr '[:upper:]' '[:lower:]'` downcases without locale surprises when `LC_ALL=C`
#   - `tr -d '!.'` deletes characters from a set, useful for stray punctuation
#   - `tr -s ' '` squeezes runs of spaces into one
#   - `tr -c '[:alnum:]\n' ' '` replaces everything not in the complement set with spaces
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/soi-11-signs.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/vendor-board.txt $workdir/
cd -- "$workdir"

# region: downcase
# focus: tr '[:upper:]' '[:lower:]'
print "== board downcased for the night-market printer:"
tr '[:upper:]' '[:lower:]' < vendor-board.txt
# endregion: downcase

# region: delete-chars
# focus: tr -d '!.'
print "== same lines with bangs and dots removed:"
tr '[:upper:]' '[:lower:]' < vendor-board.txt | tr -d '!.'
# endregion: delete-chars

# region: squeeze-spaces
# focus: tr -s ' '
print "== squeezed to single spaces:"
tr '[:upper:]' '[:lower:]' < vendor-board.txt | tr -d '!.' | tr -s ' '
# endregion: squeeze-spaces

# region: complement
# focus: tr -c '[:alnum:]\n' ' '
print "== alnum and newlines kept, other symbols blanked:"
tr '[:upper:]' '[:lower:]' < vendor-board.txt | tr -c '[:alnum:]\n' ' ' | tr -s ' '
# endregion: complement