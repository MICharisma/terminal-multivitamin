#!/usr/bin/env zsh
# Finding files with find and xargs · 02 · Istanbul ferry engine logs since the dry-dock inspection
#
# Teaches:
#   - `-newer report.txt` matches files modified after the reference file was
#   - `! -newer` means "not newer": older, or exactly as old
#   - two reference files made with `touch -t` mark a date window, with no date
#     parsing, so BSD and GNU `find` agree
#   - `cp` without `-p` stamps the copy with the current time, so `-newer` sees it as new
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sehir-hatlari.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for ferry in moda kartal baris-manco; do
  mkdir -p engine-room/$ferry
  for day in 04 08 11 13; do
    log=engine-room/$ferry/engine-2026-11-$day.log
    print "$ferry: main engine 1450 rpm, coolant 82 C, Kadikoy-Karakoy crossing" > $log
    touch -t 202611${day}1930 $log
  done
done
print "dry-dock inspection at Hasköy: propeller shafts realigned" > inspection-2026-11-08.txt
touch -t 202611081200 inspection-2026-11-08.txt

# region: newer-than-inspection
# focus: -newer inspection-2026-11-08.txt
since=( ${(f)"$(find engine-room -name '*.log' -newer inspection-2026-11-08.txt | sort)"} )
days=( ${(u)since:t} )
print "logs written after the inspection: $#since, covering ${(j:, :)days}"
# endregion: newer-than-inspection

# region: not-newer
# focus: ! -newer inspection-2026-11-08.txt
print "== before the inspection, for the shipyard's file:"
find engine-room -name '*.log' ! -newer inspection-2026-11-08.txt | sort
# endregion: not-newer

# region: date-window
# focus: find engine-room -name '*.log' -newer $from ! -newer $to
logs_between() {
  local from=window-start.stamp to=window-end.stamp
  touch -t ${1}0000 $from
  touch -t ${2}2359 $to
  find engine-room -name '*.log' -newer $from ! -newer $to | sort
  rm -f -- $from $to
}
print "== the Kartal's logs for 9 to 12 November, when the coolant alarm sounded:"
logs_between 20261109 20261112 | grep /kartal/
# endregion: date-window

# region: copy-refreshes-time
# focus: cp -p
mkdir -p for-chief-engineer
cp engine-room/moda/engine-2026-11-04.log for-chief-engineer/plain-copy.log
cp -p engine-room/moda/engine-2026-11-04.log for-chief-engineer/kept-time.log
print "== copies of the 4 November log that look newer than the inspection:"
find for-chief-engineer -type f -newer inspection-2026-11-08.txt
# endregion: copy-refreshes-time
