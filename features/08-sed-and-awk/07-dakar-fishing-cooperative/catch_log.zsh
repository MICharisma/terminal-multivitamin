#!/usr/bin/env zsh
# Editing streams with sed and awk · 07 · Dakar fishing cooperative
#
# Teaches:
#   - an `awk` pattern before `{action}` runs the action only on matching lines
#   - a regex pattern like `/species/` matches anywhere on the line
#   - a comparison pattern like `$3 >= 40` treats fields as strings unless numeric
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/yoff-cooperative.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/landing-log.csv .

summarize_species() {
  local species=$1
  awk -F, -v fish=$species '$2 == fish {sum += $3; count += 1}
    END { printf "%s: %d landings, %d kg\n", fish, count, sum }' landing-log.csv
}

# region: regex-pattern
# focus: /thiof/
print "== thiof lines for the smokehouse:"
awk -F, '/thiof/ {print $1, $3 "kg"}' landing-log.csv
# endregion: regex-pattern

# region: comparison-pattern
# focus: $3 >= 40
print "== heavy crates for the ice truck:"
awk -F, '$3 >= 40 {print $1, $2, $3}' landing-log.csv
# endregion: comparison-pattern

# region: action-block
# focus: summarize_species thiof
print "== totals the buyers asked for:"
summarize_species thiof
summarize_species sardinelle
# endregion: action-block