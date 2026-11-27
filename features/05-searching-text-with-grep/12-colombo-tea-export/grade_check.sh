#!/bin/sh
# Searching text with grep · 12 · Colombo tea export desk, grading the catalogue, in portable sh
#
# Teaches:
#   - POSIX `grep` has `-F` `-E` `-i` `-v` `-c` `-l` `-n` `-x`; it does not require GNU extensions
#   - `grep -x` matches a whole line only: grade `BOP` does not match `BOPF`
#   - `grep -e` in a loop builds an OR of fixed grades without needing `-E` alternation
#   - exit status under `set -e` needs `grep … || test $? = 1` (or `if grep`) so "no match" is not a failure
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ceylon-tea-desk.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cat > catalogue.txt <<'CAT'
lot-88 Nuwara Eliya BOP 1.2t
lot-89 Uva BOPF 0.8t
lot-90 Dimbula FBOP 1.5t
lot-91 Uva BOP 2.0t
lot-92 Ruhuna Dust 0.4t
lot-93 Nuwara Eliya OP 0.9t
lot-94 Dimbula BOP 1.1t
CAT

# region: whole-line-grade
# focus: grep -x
# Build one-grade-per-line files to show -x against a field extracted with cut-like tooling.
awk '{print $4}' catalogue.txt > grades.txt
echo "== grade BOP as a whole line (not BOPF):"
grep -x BOP grades.txt | wc -l | tr -d ' ' | awk '{print $1 " lots"}'
# endregion: whole-line-grade

# region: fixed-or
# focus: grep -F -e BOP -e FBOP
echo "== orthodox leaf grades for the London buyer:"
grep -F -e BOP -e FBOP -e OP catalogue.txt | grep -v BOPF || true
# endregion: fixed-or

# region: invert-dust
# focus: grep -v Dust
echo "== catalogue without Dust (broken leaf stays):"
grep -v Dust catalogue.txt
# endregion: invert-dust

# region: no-match-status
# focus: grep -q
if grep -q Silver catalogue.txt; then
  echo "unexpected Silver tips in the catalogue"
else
  echo "no Silver tips today; status 1 handled with if grep -q"
fi
# endregion: no-match-status
