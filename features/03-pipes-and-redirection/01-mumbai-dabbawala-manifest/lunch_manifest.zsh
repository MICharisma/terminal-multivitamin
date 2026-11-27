#!/usr/bin/env zsh
# Pipes and redirection · 01 · Mumbai dabbawala lunch manifest
#
# Teaches:
#   - `>` creates a file, or empties an existing one, before the command writes; `>>` adds to the end
#   - `|` feeds one command's output to the next: `cut | sort | uniq -c` counts tiffins per station
#   - `uniq -c` pads its counts differently on BSD and GNU; `read` strips the padding
#   - `setopt noclobber` makes `>` refuse to replace a file; `>|` replaces it on purpose
#   - `sort f > f` empties `f` before `sort` opens it: sort into a new file, then `mv`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dabbawala-andheri.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

lines_in() { print $(( $(wc -l < $1) )) }

# region: morning-pickups
# focus: > manifest.txt
print -l "churchgate,Mehta & Sons, Fort" \
         "lower-parel,Iyer household, flat 1204" \
         "churchgate,Bombay Stock Exchange, desk 31" \
         "dadar,Kulkarni Engineering, Plaza building" \
         "churchgate,Sharma Advocates, Nariman Point 7F" > manifest.txt
print "morning pickups in Andheri: $(lines_in manifest.txt)"
# endregion: morning-pickups

# region: late-orders
# focus: >> manifest.txt
print "lower-parel,D'Souza Design, Kamala Mills" >> manifest.txt
print "dadar,Patil Eye Clinic, Ranade Road"      >> manifest.txt
print "after the 10:30 phone calls: $(lines_in manifest.txt)"
# endregion: late-orders

# region: count-per-station
# focus: cut -d, -f1 manifest.txt | sort | uniq -c
print "== tiffins per station, busiest first:"
cut -d, -f1 manifest.txt | sort | uniq -c | sort -k1,1nr -k2,2 |
  while read -r count station; do
    printf '%-12s %d\n' $station $count
  done
# endregion: count-per-station

# region: noclobber
# focus: >| practice-run.txt
setopt noclobber
cp manifest.txt practice-run.txt
if ! { print "dadar,Kulkarni Engineering, Plaza building" > practice-run.txt } 2>/dev/null; then
  print "noclobber: > refused to replace practice-run.txt, $(lines_in practice-run.txt) lines kept"
fi
print "dadar,Kulkarni Engineering, Plaza building" >| practice-run.txt
print ">| replaced it on purpose: $(lines_in practice-run.txt) line"
# endregion: noclobber

# region: sort-in-place-trap
# focus: sort manifest.txt > manifest.sorted && mv manifest.sorted manifest.txt
cp manifest.txt practice-run.txt
if ! { sort practice-run.txt > practice-run.txt } 2>/dev/null; then
  print "noclobber also stops: sort practice-run.txt > practice-run.txt"
fi
unsetopt noclobber
sort practice-run.txt > practice-run.txt
print "without noclobber it runs, and leaves $(lines_in practice-run.txt) lines"
sort manifest.txt > manifest.sorted && mv manifest.sorted manifest.txt
print "== sorted the safe way, $(lines_in manifest.txt) lines for the Churchgate train:"
cat manifest.txt
# endregion: sort-in-place-trap
