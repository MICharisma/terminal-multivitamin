#!/bin/sh
# Finding files with find and xargs · 10 · Stellenbosch wine estate, fermentation tank alarms, in portable sh
#
# Teaches:
#   - `-exec grep -c ALARM {} \;` runs grep once per file, and grep with one file prints no file name
#   - `-exec ... {} +` passes many files to one grep, which then prefixes each count with its file
#   - adding `/dev/null` as an extra file makes grep name the file even when `find` hands it only one
#   - a failing `-exec ... \;` is just a false test, but a failing `-exec ... {} +` makes `find`
#     itself exit non-zero (POSIX says so), which matters under `set -e`
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kelder-tenks.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p cellar/chenin cellar/pinotage
printf '%s\n' "06:00 14.2C" "12:00 22.9C" "18:00 ALARM 29.4C cap too thick, pump over" \
  "23:00 ALARM 28.6C" > cellar/pinotage/tank-03.log
printf '%s\n' "06:00 13.8C" "12:00 18.1C" "18:00 19.0C" > cellar/chenin/tank-05.log
printf '%s\n' "06:00 15.1C" "12:00 ALARM 27.9C glycol valve stuck" > cellar/chenin/tank-07.log

# region: one-per-file
# focus: -exec grep -c ALARM {} \;
printf '%s\n' '== -exec ... \; : one grep per tank, counts without names:'
find cellar -name '*.log' -exec grep -c ALARM {} \; | sort
# endregion: one-per-file

# region: batched
# focus: -exec grep -c ALARM {} +
echo "== -exec ... + : one grep for all tanks, so it names each one:"
find cellar -name '*.log' -exec grep -c ALARM {} + | sort
# endregion: batched

# region: dev-null-trick
# focus: -exec grep ALARM /dev/null {} +
echo "== only tank-07 matches the -name test; grep alone hides which file it read:"
find cellar -name 'tank-07.log' -exec grep ALARM {} +
echo "== with /dev/null as a second file, grep names it:"
find cellar -name 'tank-07.log' -exec grep ALARM /dev/null {} +
# endregion: dev-null-trick

# region: exit-status
# focus: if find cellar/chenin -name 'tank-05.log' -exec grep -q ALARM {} +; then
if find cellar/chenin -name 'tank-05.log' -exec grep -q ALARM {} \; ; then
  printf '%s\n' 'with \; find exits 0 even though grep found no alarm in tank-05'
fi
if find cellar/chenin -name 'tank-05.log' -exec grep -q ALARM {} +; then
  echo "tank-05 has alarms"
else
  echo "with + find passes on grep's failure: no alarms in tank-05, and set -e would stop here"
fi
# endregion: exit-status
