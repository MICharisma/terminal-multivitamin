#!/usr/bin/env zsh
# Processes and jobs · 11 · Muscat desalination plant, finding who holds the valve lock
#
# Teaches:
#   - `lsof filename` lists every process that has that file open
#   - hold a lock by keeping a file descriptor open: `exec {fd}<>lock` in a child
#   - `lsof -t file` prints just the pid, handy for scripts
#   - after the holder exits, `lsof` finds nobody; delete the lock file only then
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/desal-bawshar.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

# region: hold-lock
# focus: exec {fd}<>$lock
print -r -- '#!/usr/bin/env zsh
lock=$1
trap "exit 0" TERM
exec {fd}<>$lock
print "holding $lock on fd $fd" > holder.txt
while true; do sleep 0.1; done' > hold_lock.zsh
chmod +x hold_lock.zsh
: > valve-7.lock
./hold_lock.zsh valve-7.lock &
workers+=( $! )
holder=$workers[-1]
sleep 0.2
print "== holder says: $(< holder.txt)"
# endregion: hold-lock

# region: lsof-list
# focus: lsof -Fpc valve-7.lock
print "== who has valve-7.lock open:"
# -Fpc: machine-usable; p=pid, c=command. Hide the pid.
lsof -Fpc valve-7.lock | while IFS= read -r line; do
  case $line in
    (p*) print "  pid=PID" ;;
    (c*) print "  command=${line#c}" ;;
  esac
done
# endregion: lsof-list

# region: lsof-t
# focus: lsof -t valve-7.lock
found=$(lsof -t valve-7.lock)
print "== lsof -t count: $(print -l -- $found | grep -c .)"
# endregion: lsof-t

# region: release
# focus: kill -TERM $holder
kill -TERM $holder
wait $holder
workers=()
sleep 0.1
if lsof valve-7.lock >/dev/null 2>&1; then
  print "== lock still held"
else
  print "== lock free; removing valve-7.lock"
  rm -- valve-7.lock
fi
# endregion: release
