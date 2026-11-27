#!/usr/bin/env zsh
# Pipes and redirection · 04 · Cork secondary school, Skellig Michael trip letters
#
# Teaches:
#   - a here-doc (`<<WORD ... WORD`) feeds the lines between the markers to a command's stdin
#   - an unquoted marker expands `$variables` and `$(commands)` inside; a quoted one (`<<'WORD'`) keeps them literal
#   - `done <<'ROSTER'` feeds a whole `while read` loop from lines kept in the script
#   - `<<-WORD` strips leading tabs (not spaces), so the body can be indented inside a function
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/presentation-college-cork.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir letters

trip_day="Thursday 4 June"
fee=45

# region: literal-script
# focus: cat > remind.zsh <<'SCRIPT'
cat > remind.zsh <<'SCRIPT'
#!/usr/bin/env zsh
print "Reminder for $1: bring the signed form and €$2 to Ms Ní Bhriain by Friday."
SCRIPT
# endregion: literal-script

# region: tab-stripped
# focus: cat <<-KIT
kit_list() {
	cat <<-KIT
		- waterproof jacket and boots (618 steps to the monastery)
		- packed lunch and water
		- seasickness tablets for the boat from Portmagee
	KIT
}
# endregion: tab-stripped

# region: roster-loop
# focus: while IFS=, read -r first last guardian
while IFS=, read -r first last guardian; do
  # endregion: roster-loop
  # region: expanding-letter
  # focus: > letters/$first-$last.txt <<LETTER
  cat > letters/$first-$last.txt <<LETTER
Dear $guardian,

$first $last is invited on the Transition Year trip to Skellig Michael
on $trip_day. The cost is €$fee, covering the bus and the boat.
Please bring:
$(kit_list)
LETTER
  # endregion: expanding-letter
  # region: roster-end
  # focus: done <<'ROSTER'
  zsh remind.zsh $first $fee
done <<'ROSTER'
Aoife,Murphy,Mrs Siobhán Murphy
Cian,O'Sullivan,Mr Dónal O'Sullivan
Niamh,Walsh,Ms Gráinne Walsh
ROSTER
# endregion: roster-end

# region: show-letter
# focus: cat letters/Cian-O\'Sullivan.txt
written=( letters/*(:t) )
print "== letters written: ${(j:, :)written}"
print "== the letter for the O'Sullivans:"
cat letters/Cian-O\'Sullivan.txt
# endregion: show-letter
