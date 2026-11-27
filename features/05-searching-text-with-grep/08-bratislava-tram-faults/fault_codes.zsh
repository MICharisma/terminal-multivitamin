#!/usr/bin/env zsh
# Searching text with grep · 08 · Bratislava tram depot, matching fault codes literally
#
# Teaches:
#   - `grep -F` (or `fgrep`) treats the pattern as a fixed string: `.` `*` `[` mean themselves
#   - without `-F`, `Pantograph[2]` is a character class matching `Pantograph2`; with `-F` it is literal
#   - `-F` is the right tool when the needle comes from a log line you are pasting back in
#   - combine `-F` with `-n` or `-w` as usual; it only changes how the pattern is read
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dpb-tram-depot.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -l \
  "07:12 tram-7101 Pantograph[2] pressure low, delayed at Račianske mýto" \
  "07:18 tram-7104 Door*3 sensor intermittent, continued to Zimný štadión" \
  "07:25 tram-7101 Pantograph2 reset by driver, pressure normal" \
  "07:40 tram-7112 Inverter.temp warning cleared after coasting" \
  "07:55 tram-7104 Door*3 replaced, test run OK" \
  "08:02 tram-7108 Pantograph[2] inspection due at 5000 km" > faults.txt

# region: without-f
# focus: grep 'Pantograph[2]' faults.txt
print "== without -F, [2] is a character class (matches Pantograph2):"
grep 'Pantograph[2]' faults.txt
# endregion: without-f

# region: with-f
# focus: grep -F 'Pantograph[2]' faults.txt
print "== with -F, the brackets are literal:"
grep -F 'Pantograph[2]' faults.txt
# endregion: with-f

# region: star-literal
# focus: grep -F 'Door*3' faults.txt
print "== Door*3 as a fixed string:"
grep -F 'Door*3' faults.txt
# endregion: star-literal

# region: pasted-line
# focus: grep -Fn 'Inverter.temp' faults.txt
print "== paste from the SCADA screen, dots and all:"
grep -Fn 'Inverter.temp' faults.txt
# endregion: pasted-line
