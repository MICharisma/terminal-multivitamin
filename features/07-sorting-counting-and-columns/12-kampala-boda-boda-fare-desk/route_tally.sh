#!/bin/sh
# Sorting, counting, and columns · 12 · Kampala boda-boda fare desk, tallying popular routes
#
# Teaches:
#   - POSIX `sh` can count routes with `cut`, `sort`, and `uniq -c` when bash is unavailable
#   - `cut -f1,2` pulls origin and destination from a tab-separated ride log
#   - sorting before `uniq -c` merges identical routes, and padding on the count is ignored if you read two fields
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/boda-desk.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
dir=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
cp -- "$dir/fixtures/ride-log.tsv" "$workdir/"
cd -- "$workdir"

# region: route-fields
# focus: cut -f1,2 ride-log.tsv
printf '== paired pickup and drop-off columns:\n'
cut -f1,2 ride-log.tsv | while IFS= read -r line; do
  printf '  %s\n' "$line"
done
# endregion: route-fields

# region: route-tally
# focus: cut -f1,2 ride-log.tsv | sort | uniq -c
printf '== tally for the evening tariff board:\n'
cut -f1,2 ride-log.tsv | sort | uniq -c | while read -r count route; do
  printf '  %3s %s\n' "$count" "$route"
done
# endregion: route-tally