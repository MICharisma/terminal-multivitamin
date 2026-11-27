#!/usr/bin/env zsh
# requires: macos
# Processes and jobs · 13 · Kyoto tea house, keeping the Mac awake for a long steep
#
# Teaches:
#   - `caffeinate -w $pid` stays running until that process exits, and holds idle sleep off
#   - start the steep timer first, then point `caffeinate` at its pid
#   - when the timer exits, `caffeinate` exits too: `wait` on both
#   - macOS only; on Linux the script prints a message and exits 2
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "caffeinate_timer.zsh uses caffeinate, which is a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tea-house-gion.XXXXXX")
typeset -a workers=()
cleanup() {
  local pid
  for pid in $workers; kill -TERM $pid 2>/dev/null || true
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
trap "print steep interrupted > steep.log; exit 1" TERM
print "gyokuro steeping, 90 seconds of wall time (demo: 0.3s)" > steep.log
sleep 0.3
print "steep done, serve at 60 C" >> steep.log' > steep.zsh
chmod +x steep.zsh

# region: start-timer
# focus: ./steep.zsh &
./steep.zsh &
workers+=( $! )
steep=$workers[-1]
print "== steep timer started"
# endregion: start-timer

# region: caffeinate
# focus: caffeinate -w $steep
caffeinate -w $steep &
workers+=( $! )
keeper=$workers[-1]
print "== caffeinate watching the steep pid"
# endregion: caffeinate

# region: wait-both
# focus: wait $steep
wait $steep
wait $keeper
workers=()
print "== both exited:"
sed 's/^/  /' steep.log
# endregion: wait-both
