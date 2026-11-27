#!/usr/bin/env zsh
# Editing streams with sed and awk · 02 · Yangon ferry timetable
#
# Teaches:
#   - `sed -n 'Np'` prints only line N; a range `N,Mp` prints that block
#   - `sed -n '/pattern/p'` prints lines that match a address
#   - `sed -n '/from/,/to/p'` prints from a start match through an end match
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/yangon-ferry.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p schedules
print "route: dala-south" > schedules/dala-south-2026-11-22.txt
print $'06:30 jetty-1 -> dala\n07:15 dala -> jetty-1\n18:40 jetty-1 -> dala' >> schedules/dala-south-2026-11-22.txt
print "route: innya-lake" > schedules/innya-lake-2026-11-22.txt
print $'08:00 u-bein -> shore\n12:30 shore -> u-bein' >> schedules/innya-lake-2026-11-22.txt

# region: line-number
# focus: sed -n '2,4p'
for sheet in schedules/*.txt(N); do
  print "== ${sheet:t:r} lines 2-4:"
  sed -n '2,4p' $sheet
done
# endregion: line-number

# region: pattern-address
# focus: sed -n '/jetty/p'
print "== dala sailings touching jetty-1:"
sed -n '/jetty/p' schedules/dala-south-2026-11-22.txt
# endregion: pattern-address

# region: range-address
# focus: sed -n '/07:15/,/18:40/p'
print "== afternoon block on the dala run:"
sed -n '/07:15/,/18:40/p' schedules/dala-south-2026-11-22.txt
# endregion: range-address