#!/usr/bin/env zsh
# Processes and jobs · 10 · Riga puppet theatre, cleaning up stage workers with trap
#
# Teaches:
#   - `trap stop_workers EXIT` runs on every exit path: success, `exit`, and most signals
#   - start workers, record their pids, and have the trap kill anything still running
#   - a function with its own trap shows the failure path without failing the parent script
#   - after the trap runs, `pgrep` finds nobody from that batch
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/lellu-teatris.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
trap "exit 0" TERM
print "puppeteer $1 ready" > $1.ready
while true; do sleep 0.1; done' > puppeteer.zsh
chmod +x puppeteer.zsh

rehearse() {
  : > worker.pids

  # region: install-trap
  # focus: trap stop_workers EXIT
  stop_workers() {
    local pid
    for pid in $(cat worker.pids 2>/dev/null); do
      kill -TERM $pid 2>/dev/null || true
    done
    wait 2>/dev/null || true
    : > worker.pids
  }
  trap stop_workers EXIT
  # endregion: install-trap

  # region: start-workers
  # focus: print $! >> worker.pids
  for role in kaspar buratino marionette; do
    ./puppeteer.zsh $role &
    print $! >> worker.pids
  done
  sleep 0.15
  print "  stage hands up: $(( $(wc -l < worker.pids) ))"
  # endregion: start-workers

  if [[ $1 == fail ]]; then
    # region: fail-exit
    # focus: return 1
    print "  rope snaps: return 1, trap must clean up"
    return 1
    # endregion: fail-exit
  fi

  stop_workers
  print "  rehearsal ended cleanly"
}

# region: run-both
# focus: rehearse ok
print "== evening rehearsal:"
rehearse ok
print "== afternoon rehearsal that fails:"
rehearse fail || print "  outer shell saw exit $?"
sleep 0.15
if pgrep -f 'puppeteer.zsh' >/dev/null; then
  print "  orphans left behind"
else
  print "  no puppeteer processes left"
fi
# endregion: run-both
