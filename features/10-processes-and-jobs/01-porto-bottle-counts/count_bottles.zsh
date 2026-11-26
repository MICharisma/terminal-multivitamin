#!/usr/bin/env zsh
# Processes and jobs · 01 · Porto wine lodge, counting bottles in three lodges at once
#
# Teaches:
#   - `command &` starts a background job; `$!` is its process id
#   - keep the pids in an array and `wait $pid` for each one
#   - `wait` with no arguments waits for every remaining child
#   - a trap on EXIT kills any worker still alive, so a failed run leaves nothing behind
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/taylor-fladgate.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

mkdir lodges results
print -l {001..040}.bottle > lodges/vintage-2011.txt
print -l {001..040}.bottle > lodges/late-bottled-2017.txt
print -l {001..018}.bottle > lodges/white-dry.txt
print -l {001..012}.bottle > lodges/tawny-10.txt

# region: launch
# focus: count_lodge $lodge &
count_lodge() {
  local lodge=$1
  sleep 0.05
  print $(( $(wc -l < lodges/$lodge.txt) )) > results/$lodge.count
}
typeset -a lodges=( vintage-2011 late-bottled-2017 white-dry )
for lodge in $lodges; do
  count_lodge $lodge &
  workers+=( $! )
  print "started $lodge in the background"
done
# endregion: launch

# region: wait-each
# focus: wait $workers[i]
print "== waiting for each counter:"
for i in {1..$#lodges}; do
  wait $workers[i]
  print "  $lodges[i]: $(< results/$lodges[i].count) bottles"
done
workers=()
# endregion: wait-each

# region: wait-all
# focus: wait
count_lodge tawny-10 &
workers+=( $! )
print "tawny-10 recount started; wait with no arguments..."
wait
print "  tawny-10: $(< results/tawny-10.count) bottles"
workers=()
# endregion: wait-all
