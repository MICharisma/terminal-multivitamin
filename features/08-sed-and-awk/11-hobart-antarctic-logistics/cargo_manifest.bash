#!/usr/bin/env bash
# Editing streams with sed and awk · 11 · Hobart Antarctic logistics
#
# Teaches:
#   - `sed` can strip shipment tags before `awk` totals a column
#   - process substitution `< <(cmd)` feeds a pipeline into a second command without a temp file
#   - a here-string `cmd <<< data` is enough when the input is one small blob
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/hobart-aad.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- "$(dirname -- "$0")/fixtures/container-lines.txt" .

# region: sed-then-awk
# focus: sed 's/^TAG-//'
printf '%s\n' "== kilograms per destination after stripping tags:"
sed 's/^TAG-//' container-lines.txt |
  awk -F'|' '{ kg[$2] += $3 } END { for (d in kg) print kg[d], d }' | sort -rn
# endregion: sed-then-awk

# region: process-substitution
# focus: done < <(sed 's/^TAG-//' container-lines.txt | awk -F'|' '$3 >= 500')
printf '%s\n' "== manifests at least 500 kg:"
while IFS='|' read -r item dest mass; do
  printf '  %s -> %s (%s kg)\n' "$item" "$dest" "$mass"
done < <(sed 's/^TAG-//' container-lines.txt | awk -F'|' '$3 >= 500')
# endregion: process-substitution

# region: here-string
# focus: <<< "$(sed 's/^TAG-//' container-lines.txt)"
printf '%s\n' "== heaviest single line:"
awk -F'|' '{
  if ($3 > best) { best = $3; line = $0 }
} END { print line }' <<< "$(sed 's/^TAG-//' container-lines.txt)"
# endregion: here-string