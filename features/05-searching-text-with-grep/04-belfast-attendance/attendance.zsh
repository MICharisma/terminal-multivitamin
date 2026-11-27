#!/usr/bin/env zsh
# Searching text with grep · 04 · Belfast primary school, reading today's attendance
#
# Teaches:
#   - `grep -v` prints the lines that do *not* match (the absences, or the noise to drop)
#   - `grep -c` counts matches; `grep -vc` counts the non-matches
#   - pipe filters stack: drop the header, then drop present pupils, to leave the absences
#   - `-v` with an empty match set still exits 0 when every line matched the pattern (none left)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/st-bride-belfast.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -l \
  "name,status,note" \
  "Aoife Byrne,present," \
  "Caoimhe Dunn,absent,dentist" \
  "Eoin Gallagher,present," \
  "Niamh Kerr,absent,cold" \
  "Oisin Murphy,present," \
  "Siobhan Quinn,late,bus" \
  "Turlough Reilly,present," > p4.txt

# region: invert
# focus: grep -v ',present,' p4.txt
print "== everyone who is not simply present:"
grep -v ',present,' p4.txt
# endregion: invert

# region: drop-header
# focus: grep -v '^name,'
print "== not present (header and present dropped):"
grep -v '^name,' p4.txt | grep -v ',present,'
# endregion: drop-header

# region: count-absent
# focus: grep -c ',absent,' p4.txt
print "absent: $(grep -c ',absent,' p4.txt), late: $(grep -c ',late,' p4.txt)"
# endregion: count-absent

# region: count-inverted
# focus: grep -vc ',present,' p4.txt
print "rows that are not present (includes header): $(grep -vc ',present,' p4.txt)"
print "present pupils: $(grep -c ',present,' p4.txt)"
# endregion: count-inverted
