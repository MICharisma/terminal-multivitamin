#!/usr/bin/env zsh
# Archives and compression · 10 · Cork lab datasets
#
# Teaches:
#   - an associative array maps dataset ids to source files
#   - gzip a copy (not the original) so the lab keeps the raw CSV beside the `.gz`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cork-lab.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p raw compressed
print "station,ph,nitrate\nriver-lee,7.1,1.2" > raw/lee-ph.csv
print "station,ph,nitrate\nriver-blackwater,6.9,0.8" > raw/blackwater-ph.csv
print "station,ph,nitrate\nriver-banon,7.4,1.5" > raw/banon-ph.csv

# region: dataset-table
# focus: typeset -A datasets
typeset -A datasets=(
  [lee]=raw/lee-ph.csv
  [blackwater]=raw/blackwater-ph.csv
  [banon]=raw/banon-ph.csv
)
station_names=(${(ok)datasets})
print "== datasets queued: ${(j:, :)station_names}"
# endregion: dataset-table

# region: gzip-copies
# focus: gzip
print "== compressing copies:"
for name in $station_names; do
  src=$datasets[$name]
  cp -- $src compressed/$name-ph.csv
  gzip compressed/$name-ph.csv
  print "  ${name}-ph.csv.gz"
done
# endregion: gzip-copies

# region: originals-kept
# focus: ls -1 raw
print "== raw still present:"
ls -1 raw
print "== compressed:"
ls -1 compressed
# endregion: originals-kept
