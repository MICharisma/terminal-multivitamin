#!/usr/bin/env zsh
# Archives and compression · 04 · Quito mural restoration logs
#
# Teaches:
#   - a `for` loop over each log runs `gzip` in place, leaving `.gz` beside the name
#   - `gzip -d` restores one file when a restorer needs to re-read yesterday's notes
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/quito-mural.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p journals
print "2026-11-20: cleaned soot from north wall, panel A" > journals/panel-a.log
print "2026-11-21: matched ochre pigment for the sun motif" > journals/panel-b.log
print "2026-11-22: sealed varnish on the balcony frieze"   > journals/panel-c.log

# region: gzip-each
# focus: gzip $journal
print "== compressing:"
for journal in journals/*.log; do
  gzip $journal
  print "  ${journal:t}.gz"
done
# endregion: gzip-each

# region: gunzip-one
# focus: gzip -d journals/panel-b.log.gz
gzip -d journals/panel-b.log.gz
print "== reopened panel-b:"
print "  $(< journals/panel-b.log)"
print "== still compressed:"
ls -1 journals
# endregion: gunzip-one
