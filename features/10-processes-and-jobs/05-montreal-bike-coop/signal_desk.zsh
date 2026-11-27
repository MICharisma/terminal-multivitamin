#!/usr/bin/env zsh
# Processes and jobs · 05 · Montréal bike cooperative, a repair desk that listens for signals
#
# Teaches:
#   - `trap 'handler' USR1` runs code when the process receives that signal
#   - `kill -USR1 $pid` sends it; the handler can rewrite a status file
#   - `TERM` is the polite "please stop"; a trap can shut down cleanly before exiting
#   - `HUP` is often "reload your config"; the desk rewrites its status when it arrives
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/atelier-velo-mile-end.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

# region: desk-script
# focus: trap "print reloading roster > \$desk" HUP
print -r -- '#!/usr/bin/env zsh
desk=desk.txt
print "idle, waiting for a bike" > $desk
trap "print reloading roster > \$desk" HUP
trap "print finishing the bolt, then quitting > \$desk; exit 0" TERM
trap "print now servicing a cargo bike > \$desk" USR1
while true; do sleep 0.1; done' > repair_desk.zsh
chmod +x repair_desk.zsh
# endregion: desk-script

# region: start-desk
# focus: ./repair_desk.zsh &
./repair_desk.zsh &
workers+=( $! )
desk=$workers[-1]
sleep 0.15
print "== desk opened: $(< desk.txt)"
# endregion: start-desk

# region: usr1
# focus: kill -USR1 $desk
kill -USR1 $desk
sleep 0.15
print "== after USR1: $(< desk.txt)"
# endregion: usr1

# region: hup
# focus: kill -HUP $desk
kill -HUP $desk
sleep 0.15
print "== after HUP: $(< desk.txt)"
# endregion: hup

# region: term
# focus: kill -TERM $desk
kill -TERM $desk
wait $desk
print "== after TERM: $(< desk.txt)"
workers=()
# endregion: term
