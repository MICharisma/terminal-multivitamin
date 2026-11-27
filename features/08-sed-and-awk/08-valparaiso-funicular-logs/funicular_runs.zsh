#!/usr/bin/env zsh
# Editing streams with sed and awk · 08 · Valparaíso funicular logs
#
# Teaches:
#   - `BEGIN` runs before input; `END` runs after the last line
#   - awk arrays use `array[key]` with string or numeric keys
#   - `length(array)` counts elements; `length(string)` counts characters
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ascensores.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/car-runs.tsv .

# region: begin-end
# focus: END
print "== passengers per car since the maintenance window:"
awk -F'\t' '
  { riders[$1] += $2 }
  END {
    for (car in riders) print car, riders[car]
  }' car-runs.tsv | sort -k1
# endregion: begin-end

# region: length-array
# focus: length(riders)
print "== how many cars carried riders today:"
awk -F'\t' '{riders[$1] += $2} END {print length(riders)}' car-runs.tsv
# endregion: length-array

# region: length-string
# focus: length($1)
print "== longest car code on the log:"
awk -F'\t' '{ if (length($1) > m) { m = length($1); name = $1 } }
  END { print name, m " chars" }' car-runs.tsv
# endregion: length-string