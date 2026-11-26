#!/bin/sh
# Globbing and expansion · 12 · Wellington Cable Car brake logs, in portable sh
#
# Teaches:
#   - POSIX sh has no null_glob: an unmatched glob stays as the literal pattern,
#     so loops guard with [ -e "$log" ] || continue
#   - set -- pattern loads matches into "$@" and lets you count them with $#
#   - case patterns use the same * ? [ ] syntax as filename globs, including [!...]
#   - ${log##*/} and ${name%.log} trim a path without calling basename
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cable-car-brakes.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir logs
for log in car-1_service-2026-11-03 car-2_service-2026-11-03 car-1_emergency-2026-11-17 \
           car-2_service-2026-11-24 car-1_service-2026-11-24 car-3_service-2026-11-10; do
  echo "track brake pads 9.5 mm, rail brake test passed" > "logs/$log.log"
done

# region: guarded-loop
# focus: [ -e "$log" ] || continue
for log in logs/*.log; do
  [ -e "$log" ] || continue
  name=${log##*/}
  name=${name%.log}
  # endregion: guarded-loop
  # region: case-patterns
  # focus: *_emergency-*)
  case $name in
    *_emergency-*) echo "URGENT  $name: emergency stop, check the Kelburn end" ;;
    car-[12]_service-????-11-2[0-9]) echo "recent  $name" ;;
    car-[!12]_*) echo "unknown car in $name" ;;
    *) echo "routine $name" ;;
  esac
  # endregion: case-patterns
done

# region: count-with-set
# focus: set -- logs/*_emergency-*.log
set -- logs/*_emergency-*.log
[ -e "$1" ] || set --
echo "emergency logs this month: $#"
# endregion: count-with-set

# region: literal-leftover
# focus: for report in logs/*.pdf
for report in logs/*.pdf; do
  echo "without a guard the loop sees: $report"
done
# endregion: literal-leftover
