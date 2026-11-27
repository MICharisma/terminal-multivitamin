#!/usr/bin/env bash
# Sorting, counting, and columns · 11 · Jaipur puppet theatre, counting cues for the night show
#
# Teaches:
#   - in bash, `sort | uniq -c` with a function still pads counts differently on BSD and GNU;
#     `read -r count label` drops the padding
#   - process substitution `< <(...)` keeps the loop in the current shell so a ranked array survives
#   - works in macOS's bash 3.2: build the array with `ranked+=("$row")` instead of `mapfile`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/rangmahal-cues.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- "$(cd "$(dirname "$0")" && pwd)/fixtures/show-cues.txt" "$workdir/"
cd -- "$workdir"

# region: tally-bash
# focus: sort show-cues.txt | uniq -c
print_rank() {
  local count label
  while read -r count label; do
    printf '  %3s %s\n' "$count" "$label"
  done
}
echo "== cues by frequency for the puppet master:"
sort show-cues.txt | uniq -c | print_rank
# endregion: tally-bash

# region: ranked-array
# focus: ranked+=("$row")
ranked=()
while IFS= read -r row; do
  ranked+=("$row")
done < <(sort show-cues.txt | uniq -c | sort -k1,1nr -k2,2)
echo "== top two cues saved for the call sheet:"
i=0
for row in "${ranked[@]}"; do
  [ "$i" -eq 2 ] && break
  read -r count label <<<"$row"
  printf '  %s x %s\n' "$count" "$label"
  i=$((i + 1))
done
# endregion: ranked-array
