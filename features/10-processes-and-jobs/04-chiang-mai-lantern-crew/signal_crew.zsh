#!/usr/bin/env zsh
# Processes and jobs · 04 · Chiang Mai temple school, signalling the lantern crew
#
# Teaches:
#   - `pgrep -f pattern` finds process ids by matching the full command line
#   - `pgrep -P $ppid` finds children of one parent; combine with `-f` for a shortlist
#   - `pkill -TERM -f pattern` sends a signal by the same match; it returns 1 when nobody matched
#   - prefer matching a unique marker in the command (`lantern-crew:gate`) over a bare `sleep`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/wat-chedi-luang.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  pkill -TERM -f 'lantern-crew:' 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

crew_name() {
  ps -o command= -p $1 | awk '{ print $1 }'
}

# argv[0] rewrite so pgrep -f sees our marker: exec -a
start_crew() {
  local post=$1
  ( exec -a "lantern-crew:$post" zsh -c 'trap "exit 0" TERM; while true; do sleep 0.1; done' ) &
  workers+=( $! )
}

# region: start-crew
# focus: start_crew gate
start_crew gate
start_crew river
start_crew roof
sleep 0.1
print "crew started: $#workers lantern posts"
# endregion: start-crew

# region: pgrep-children
# focus: pgrep -P $$ -f 'lantern-crew:'
print "== our lantern crew (children of this script):"
pgrep -P $$ -f 'lantern-crew:' | while read -r pid; do
  print "  $(crew_name $pid)"
done | sort
# endregion: pgrep-children

# region: pgrep-one
# focus: pgrep -f 'lantern-crew:river'
river_pid=$(pgrep -f 'lantern-crew:river')
print "== river post only: $(crew_name $river_pid)"
# endregion: pgrep-one

# region: pkill-one
# focus: pkill -TERM -f 'lantern-crew:river'
pkill -TERM -f 'lantern-crew:river'
sleep 0.15
workers=( ${workers:#$river_pid} )
print "== after pkill on river:"
pgrep -P $$ -f 'lantern-crew:' | while read -r pid; do
  print "  still up: $(crew_name $pid)"
done | sort
# endregion: pkill-one

# region: pkill-rest
# focus: pkill -TERM -f 'lantern-crew:'
pkill -TERM -f 'lantern-crew:'
sleep 0.15
workers=()
wait 2>/dev/null || true
if pgrep -f 'lantern-crew:' >/dev/null; then
  print "== cleanup failed"
else
  print "== yard clear: pkill returned and nobody matches"
fi
# endregion: pkill-rest
