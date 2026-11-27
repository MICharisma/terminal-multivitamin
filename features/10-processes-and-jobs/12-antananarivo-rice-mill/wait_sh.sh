#!/bin/sh
# Processes and jobs · 12 · Antananarivo rice mill, waiting on baggers in portable sh
#
# Teaches:
#   - POSIX `sh` has `$`! for the last background pid and `wait` for children
#   - `wait "$pid"` returns that child's exit status; a loop over pids is the portable join
#   - there is no `jobs -p` you can rely on in a script: keep the pids yourself
#   - a trap on EXIT kills anything still in the pid list, so a failed mill run leaves no baggers
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/moulins-malagasy.XXXXXX")
workers=""
cleanup() {
  for pid in $workers; do
    kill -TERM "$pid" 2>/dev/null || true
  done
  wait 2>/dev/null || true
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

cat > bagger.sh <<'SCRIPT'
#!/bin/sh
trap 'exit 0' TERM
bags=$1
out=$2
n=0
while [ "$n" -lt "$bags" ]; do
  n=$((n + 1))
  sleep 0.02
done
echo "$bags" > "$out"
SCRIPT
chmod +x bagger.sh

# region: launch
# focus: ./bagger.sh 5 results/line-a.count &
mkdir results
./bagger.sh 5 results/line-a.count &
workers="$workers $!"
./bagger.sh 8 results/line-b.count &
workers="$workers $!"
./bagger.sh 3 results/line-c.count &
workers="$workers $!"
echo "started baggers: 3 lines"
# endregion: launch

# region: wait-loop
# focus: wait "$1"
echo "== joining each bagger:"
status_a=0 status_b=0 status_c=0
# Prefer named waits so we can report per line. Re-read pids from the list.
set -- $workers
wait "$1" || status_a=$?
wait "$2" || status_b=$?
wait "$3" || status_c=$?
workers=""
echo "  line-a: $(cat results/line-a.count) bags (exit $status_a)"
echo "  line-b: $(cat results/line-b.count) bags (exit $status_b)"
echo "  line-c: $(cat results/line-c.count) bags (exit $status_c)"
# endregion: wait-loop

# region: wait-all
# focus: wait
./bagger.sh 2 results/line-d.count &
workers="$workers $!"
echo "line-d started; wait with no arguments..."
wait
workers=""
echo "  line-d: $(cat results/line-d.count) bags"
# endregion: wait-all
