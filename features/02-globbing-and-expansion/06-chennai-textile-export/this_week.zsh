#!/usr/bin/env zsh
# Globbing and expansion · 06 · Chennai textile export house, this week's purchase orders
#
# Teaches:
#   - `(m-7)` matches files modified less than 7 days ago; `(m+30)` more than 30
#   - `(mh-24)` counts in hours instead of days
#   - `(om[1])` picks the most recently modified match
#   - `zsh/datetime` gives `$EPOCHSECONDS` and `strftime`, so the script can stamp
#     files "3 days ago" with `touch -t` on both macOS and Linux
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kanchi-exports.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: stamp-ages
# focus: strftime -s stamp %Y%m%d%H%M $(( EPOCHSECONDS - hours_ago * 3600 ))
zmodload zsh/datetime
aged() {
  local file=$1 hours_ago=$2 stamp
  strftime -s stamp %Y%m%d%H%M $(( EPOCHSECONDS - hours_ago * 3600 ))
  : > $file
  touch -t $stamp $file
}
# endregion: stamp-ages
aged po-4471_hamburg_organic-cotton-tees.pdf    5
aged po-4468_rotterdam_kalamkari-cushions.pdf  26
aged po-4462_osaka_handloom-sarees.pdf         73
aged po-4450_melbourne_bedsheets.pdf          216
aged po-4391_lyon_silk-stoles.pdf             960

# region: this-week
# focus: po-*.pdf(m-7)
print "== changed in the last 7 days (for Monday's shipping meeting):"
print -l po-*.pdf(m-7)
# endregion: this-week

# region: today
# focus: po-*.pdf(mh-24)
print "== changed in the last 24 hours:"
print -l po-*.pdf(mh-24)
# endregion: today

# region: stale
# focus: po-*.pdf(m+30)
print "== untouched for over 30 days (ask the Lyon buyer):"
print -l po-*.pdf(m+30)
# endregion: stale

# region: newest
# focus: po-*.pdf(om[1])
newest=( po-*.pdf(om[1]) )
print "== most recent order: $newest"
# endregion: newest
