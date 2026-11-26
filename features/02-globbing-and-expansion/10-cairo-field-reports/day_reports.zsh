#!/usr/bin/env zsh
# Globbing and expansion · 10 · Cairo University Egyptology field season, daily reports
#
# Teaches:
#   - by default (nomatch) a glob with no matches is an error and the command never runs
#   - (N) on one glob, or setopt null_glob in a function, turns no match into nothing
#   - (( $#reports )) checks for an empty array before looping
#   - a nomatch failure can be tested safely inside a ( subshell )
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/saqqara-season.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p reports/2026-11-{20..24}
print "Trench B4: limestone offering table, Old Kingdom"    > reports/2026-11-20/trench-b4_offering-table.txt
print "Trench B4: sealing with Teti cartouche"              > reports/2026-11-20/trench-b4_sealing.txt
print "Trench C1: mud-brick wall, 3 courses"                > reports/2026-11-21/trench-c1_wall.txt
print "Friday: site closed"                                 > reports/2026-11-22/README
print "Trench C1: faience amulets (Bes) x4"                 > reports/2026-11-24/trench-c1_amulets.txt

# region: nomatch-error
# focus: ( : reports/2026-11-22/*.txt )
if ! ( : reports/2026-11-22/*.txt ) 2>/dev/null; then
  print "2026-11-22 with default options: no matches found, the command never ran"
fi
# endregion: nomatch-error

# region: null-glob-function
# focus: setopt local_options null_glob
summarize_day() {
  setopt local_options null_glob
  local day=$1
  local -a reports=( reports/$day/*.txt )
  # endregion: null-glob-function
  # region: count-before-loop
  # focus: (( $#reports ))
  if (( $#reports )); then
    print "$day: ${#reports} trench report(s)"
    for report in $reports; do
      print "  ${report:t:r}: $(< $report)"
    done
  else
    print "$day: no finds recorded"
  fi
  # endregion: count-before-loop
}

for day in reports/*(/:t); do
  summarize_day $day
done

# region: per-glob-n
# focus: reports/2026-11-23/*.txt(N)
late=( reports/2026-11-23/*.txt(N) )
print "reports filed for the 23rd: ${#late} (the inspector from the Ministry visited)"
# endregion: per-glob-n
