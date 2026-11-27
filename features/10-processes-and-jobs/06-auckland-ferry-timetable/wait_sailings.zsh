#!/usr/bin/env zsh
# Processes and jobs · 06 · Auckland ferry timetable desk, waiting on each sailing's check
#
# Teaches:
#   - `wait $pid` waits for one child and returns that child's exit status in `$?`
#   - a child that exits 0 means success; non-zero means that sailing's check failed
#   - `wait $unknown` fails immediately when the pid is not a child of this shell
#   - start the slow check first and wait in timetable order, not launch order
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fullers-auckland.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

mkdir results
check_sailing() {
  local name=$1 delay=$2 outcome=$3
  sleep $delay
  print "$name berth check" > results/$name.txt
  exit $outcome
}

# region: launch-order
# focus: check_sailing waiheke 0.30 0 &
typeset -A pid_of
check_sailing waiheke 0.30 0 &
workers+=( $! )
pid_of[waiheke]=$workers[-1]
check_sailing devonport 0.10 0 &
workers+=( $! )
pid_of[devonport]=$workers[-1]
check_sailing bayswater 0.20 1 &
workers+=( $! )
pid_of[bayswater]=$workers[-1]
print "started in launch order: waiheke, devonport, bayswater"
# endregion: launch-order

# region: wait-timetable
# focus: wait ${pid_of[$sailing]}
print "== waiting in timetable order:"
for sailing in devonport bayswater waiheke; do
  if wait ${pid_of[$sailing]}; then
    print "  $sailing: ok ($(< results/$sailing.txt))"
  else
    print "  $sailing: FAILED (exit $?)"
  fi
done
workers=()
# endregion: wait-timetable

# region: not-a-child
# focus: wait 1
print "== wait on a pid that is not our child:"
if wait 1 2>/dev/null; then
  print "  unexpected success"
else
  print "  refused (not a child of this shell)"
fi
# endregion: not-a-child
