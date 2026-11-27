#!/usr/bin/env bash
# Pipes and redirection · 09 · Hamburg container terminal crane telemetry, in bash
#
# Teaches:
#   - a pipeline's exit status is its last command's, so an early failure hides behind a happy `sort`
#   - bash's `PIPESTATUS` array holds every stage's status (zsh: `pipestatus`); copy it at once,
#     because the next command replaces it
#   - `set -o pipefail` makes the pipeline fail if any stage fails
#   - `2>&1 |` sends stderr down the pipe too; `|&` is the bash 4 shorthand, missing from macOS's bash 3.2
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/altenwerder-cranes.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# The crane's PLC drops the connection after three readings and exits 3, like a real reader would.
read_hoist_loads() {
  printf '%s\n' "STS-07 hoist 31.5t" "STS-07 hoist 40.2t" "STS-07 hoist 28.9t"
  echo "STS-07: PLC connection lost at reading 4" >&2
  return 3
}
heaviest_first() { sort -t' ' -k3,3 -rn; }

# region: hidden-failure
# focus: set +o pipefail
(
  set +o pipefail
  read_hoist_loads 2>/dev/null | heaviest_first > loads.txt
  echo "without pipefail, the pipeline reports: $? (and loads.txt has $(wc -l < loads.txt | tr -d ' ') readings)"
)
# endregion: hidden-failure

# region: pipestatus
# focus: statuses=( "${PIPESTATUS[@]}" )
(
  set +o pipefail
  read_hoist_loads 2>/dev/null | heaviest_first | head -n 1 > heaviest.txt
  statuses=( "${PIPESTATUS[@]}" )
  echo "PIPESTATUS per stage: ${statuses[*]}"
  echo "a second look is already gone: ${PIPESTATUS[*]}"
  (( statuses[0] == 3 )) && echo "the reader failed; heaviest lift so far: $(< heaviest.txt)"
)
# endregion: pipestatus

# region: pipefail
# focus: || status=$?
status=0
read_hoist_loads 2>/dev/null | heaviest_first > loads.txt || status=$?
echo "with pipefail, the pipeline reports: $status"
# endregion: pipefail

# region: stderr-down-the-pipe
# focus: 2>&1 | grep -c 'connection lost'
lost=$( { read_hoist_loads || true; } 2>&1 | grep -c 'connection lost' )
echo "connection drops seen through the pipe: $lost (|& would need bash 4)"
# endregion: stderr-down-the-pipe
