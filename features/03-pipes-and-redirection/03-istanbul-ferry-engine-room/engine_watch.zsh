#!/usr/bin/env zsh
# Pipes and redirection · 03 · Istanbul ferry engine room, comparing both engines
#
# Teaches:
#   - `< file` connects a file to a command's stdin; `read line < file` takes just the first line
#   - `while read ...; done < file` feeds the whole loop, and its variables survive the loop
#     (in bash they would not survive `cat file | while read`; redirect the loop instead)
#   - `exec 3< a 4< b` opens extra input descriptors, so one loop can read two files in step
#   - `read -u 3` reads from descriptor 3 (portable form: `read -r line <&3`); `exec 3<&-` closes it
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/sehir-hatlari-kadikoy.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/*.log $workdir/
cd -- "$workdir"

# region: first-line
# focus: read -r first_time first_route first_rpm < port-engine.log
read -r first_time first_route first_rpm < port-engine.log
print "first crossing today: $first_time $first_route, port engine $first_rpm rpm"
# endregion: first-line

# region: loop-from-file
# focus: done < port-engine.log
peak=0 peak_time=
while read -r time route rpm; do
  if (( rpm > peak )); then
    peak=$rpm peak_time=$time
  fi
done < port-engine.log
print "port engine peak: $peak rpm on the $peak_time crossing"
# endregion: loop-from-file

# region: open-descriptors
# focus: exec 3< port-engine.log 4< starboard-engine.log
exec 3< port-engine.log 4< starboard-engine.log
# endregion: open-descriptors

# region: read-in-step
# focus: read -r -u 3 time route port_rpm && read -r -u 4 _ _ starboard_rpm
print "== crossings where the engines drift more than 30 rpm apart:"
while read -r -u 3 time route port_rpm && read -r -u 4 _ _ starboard_rpm; do
  drift=$(( port_rpm - starboard_rpm ))
  if (( ${drift#-} > 30 )); then
    print "  $time $route: port $port_rpm, starboard $starboard_rpm (drift $drift)"
  fi
done
# endregion: read-in-step

# region: close-descriptors
# focus: exec 3<&- 4<&-
exec 3<&- 4<&-
if ! { read -r -u 3 time } 2>/dev/null; then
  print "descriptor 3 is closed; the chief engineer's report can be filed"
fi
# endregion: close-descriptors
