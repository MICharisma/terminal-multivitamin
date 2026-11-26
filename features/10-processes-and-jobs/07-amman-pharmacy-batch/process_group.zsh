#!/usr/bin/env zsh
# Processes and jobs · 07 · Amman pharmacy, stopping a whole labelling batch with one signal
#
# Teaches:
#   - a process group is a set of processes that share a pgid; `kill -- -$pgid` signals them all
#   - `perl -MPOSIX -e 'POSIX::setsid()...'` starts a new session (and group) portably on macOS and Linux
#   - children started inside that session inherit the group; one TERM reaches every label printer
#   - `ps -o pgid=` reads the group id; compare it with the leader to confirm they match
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pharmacy-jabal.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM -- -$pid 2>/dev/null || true
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
print "label printer $1 online" > $2
trap "print stopped > $2; exit 0" TERM
while true; do sleep 0.1; done' > printer.zsh
chmod +x printer.zsh

# region: new-session
# focus: POSIX::setsid()
perl -MPOSIX -e 'POSIX::setsid() != -1 or die "setsid: $!\n"; exec @ARGV or die "exec: $!\n"' \
  zsh -c '
    ./printer.zsh counter status-counter.txt &
    ./printer.zsh fridge  status-fridge.txt &
    ./printer.zsh otc     status-otc.txt &
    wait
  ' &
leader=$!
workers+=( $leader )
sleep 0.2
# endregion: new-session

# region: confirm-group
# focus: ps -o pgid=
pgid=$(ps -o pgid= -p $leader | tr -d ' ')
print "== labelling batch has a shared process group"
typeset -a kids=( ${(f)"$(pgrep -P $leader)"} )
for kid in $kids; do
  kid_pgid=$(ps -o pgid= -p $kid | tr -d ' ')
  station=${${$(ps -o args= -p $kid)##*printer.zsh }%% *}
  print "  $station same_group=$(( kid_pgid == pgid ))"
done | sort
# endregion: confirm-group

# region: kill-group
# focus: kill -TERM -- -$pgid
print "== one TERM to the whole group:"
kill -TERM -- -$pgid
sleep 0.2
wait $leader 2>/dev/null || true
workers=()
for station in counter fridge otc; do
  print "  $station: $(< status-$station.txt)"
done
# endregion: kill-group
