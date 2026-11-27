#!/usr/bin/env zsh
# Homebrew · 08 · Bucharest museum digitization doctor
#
# Teaches:
#   - `brew doctor` prints diagnostics; a healthy prefix still exits 0 with "ready to brew"
#   - process substitution `<( )` feeds the doctor log into `grep` without a temp file
#   - the museum run is read-only: warnings are listed, nothing is repaired here
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/mnir-digitize-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: run-doctor
# focus: brew doctor
doctor_log=$workdir/doctor.log
brew doctor > $doctor_log
print "doctor exit note: $(tail -n 1 $doctor_log)"
# endregion: run-doctor

# region: filter-warnings
# focus: grep -E
print "== warnings the digitization desk will raise at standup:"
grep -E 'Warning:|unexpected' <(cat $doctor_log) || print "(none)"
# endregion: filter-warnings
