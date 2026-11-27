#!/usr/bin/env zsh
# Processes and jobs · 03 · Prague tram depot, reading the night shift's process list
#
# Teaches:
#   - `ps -o pid,ppid,state,command` picks the columns; keep `LC_ALL=C` for a stable header
#   - `ps -p $pid` asks about one process; `ps -p $pid,$pid` about several
#   - state letters: `S` sleeping, `T` stopped (and `R` running, `Z` zombie)
#   - filter with a pid list, never with `ps aux | grep`: that race-matches itself
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dpp-vozovna.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; do
    kill -CONT $pid 2>/dev/null || true
    kill -TERM $pid 2>/dev/null || true
  done
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

for tram in tram-15-androva tram-22-palmovka; do
  print -r -- '#!/usr/bin/env zsh
trap "exit 0" TERM
while true; do sleep 0.1; done' > $tram
  chmod +x $tram
done

# region: columns
# focus: ps -o state=,command= -p ${(j:,:)workers}
./tram-15-androva &
workers+=( $! )
./tram-22-palmovka &
workers+=( $! )
sleep 0.1
print "== night shift, our own columns:"
ps -o state=,command= -p ${(j:,:)workers} | sort -k2 |
  while read -r state command; do
    print "  state=$state cmd=${command##*/}"
  done
# endregion: columns

# region: one-process
# focus: ps -o state=,command= -p $workers[1]
print "== just tram 15:"
ps -o state=,command= -p $workers[1] |
  while read -r state command; do
    print "  state=$state cmd=${command##*/}"
  done
# endregion: one-process

# region: stop-state
# focus: kill -STOP $workers[2]
kill -STOP $workers[2]
sleep 0.1
print "== after STOP on tram 22:"
ps -o state=,command= -p ${(j:,:)workers} | sort -k2 |
  while read -r state command; do
    print "  state=$state cmd=${command##*/}"
  done
kill -CONT $workers[2]
# endregion: stop-state

# region: no-grep-self
# focus: ps -o pid= -p ${(j:,:)workers}
print "== matching by pid list, not by grep:"
count=$(ps -o pid= -p ${(j:,:)workers} | grep -c '[0-9]')
print "  tracked $count of our own trams"
# endregion: no-grep-self

for pid in $workers; kill -TERM $pid 2>/dev/null || true
wait 2>/dev/null || true
workers=()
