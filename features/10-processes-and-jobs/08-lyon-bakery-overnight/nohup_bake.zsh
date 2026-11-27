#!/usr/bin/env zsh
# Processes and jobs · 08 · Lyon bakery, leaving the overnight bake running under nohup
#
# Teaches:
#   - `nohup command &` keeps the command alive after the terminal hangs up; output goes to `nohup.out`
#   - `nohup` redirects stdin from `/dev/null` and ignores `SIGHUP`
#   - the parent can exit (or just move on) while the child keeps writing its log
#   - you still own the process: `kill` it when the bake is done, and clean up `nohup.out`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/boulangerie-saint-jean.XXXXXX")
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
trap "print bake stopped; exit 0" TERM
print "poolish mixed at 22:00"
print "dough folded"
while true; do sleep 0.1; done' > overnight_bake.zsh
chmod +x overnight_bake.zsh

# region: nohup-start
# focus: nohup ./overnight_bake.zsh
nohup ./overnight_bake.zsh > bake.log 2>&1 &
workers+=( $! )
bake=$workers[-1]
sleep 0.2
print "== bake pid running under nohup"
# endregion: nohup-start

# region: nohup-ignores-hup
# focus: kill -HUP $bake
kill -HUP $bake
sleep 0.15
if kill -0 $bake 2>/dev/null; then
  print "  HUP ignored: bake still running"
else
  print "  HUP stopped the bake (unexpected)"
fi
# endregion: nohup-ignores-hup

# region: read-log
# focus: bake.log
print "== so far in bake.log:"
sed 's/^/  /' bake.log
# endregion: read-log

# region: stop-bake
# focus: kill -TERM $bake
kill -TERM $bake
wait $bake
workers=()
print "== after TERM:"
sed 's/^/  /' bake.log
# endregion: stop-bake
