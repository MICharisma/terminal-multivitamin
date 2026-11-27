#!/usr/bin/env zsh
# Finding files with find and xargs · 07 · Rotterdam container terminal, sizing crane telemetry dumps
#
# Teaches:
#   - `find -printf '%s %TY-%Tm-%Td %p\n'` is GNU only; BSD `find` on macOS rejects it
#   - `find -exec stat -f '%z %Sm %N' -t '%Y-%m-%d' {} +` prints the same line on BSD
#   - detecting `-printf` once with `find . -maxdepth 0 -printf ''` and hiding both behind one function
#   - after that, plain text tools rank the dumps, and a `while read` loop totals them per crane;
#     zsh runs the last command of a pipeline in the current shell, so the totals survive the loop
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/maasvlakte-cranes.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -A dump_bytes=(
  sts-01/plc-dump-2026-11-19.bin 18432   sts-01/plc-dump-2026-11-20.bin 20480
  sts-02/plc-dump-2026-11-19.bin 9216    sts-02/plc-dump-2026-11-20.bin 61440
  sts-03/plc-dump-2026-11-20.bin 12288
)
for dump bytes in ${(kv)dump_bytes}; do
  mkdir -p cranes/${dump:h}
  head -c $bytes /dev/zero > cranes/$dump
done
for dump in cranes/*/*.bin; do
  day=${${dump:t:r}#plc-dump-}
  touch -t ${day//-/}0600 $dump
done

# region: detect-printf
# focus: find . -maxdepth 0 -printf ''
if find . -maxdepth 0 -printf '' 2>/dev/null; then
  list_dumps() { find cranes -type f -name '*.bin' -printf '%s %TY-%Tm-%Td %p\n' }
else
  list_dumps() { find cranes -type f -name '*.bin' -exec stat -f '%z %Sm %N' -t '%Y-%m-%d' {} + }
fi
# endregion: detect-printf

# region: largest-dumps
# focus: list_dumps | sort -rn | head -n 3
print "== the three largest dumps, bytes, date, path:"
list_dumps | sort -rn | head -n 3
# endregion: largest-dumps

# region: one-day
# focus: list_dumps | grep ' 2026-11-20 '
print "== written on 20 November, when sts-02 tripped its hoist brake:"
list_dumps | grep ' 2026-11-20 ' | sort -k3
# endregion: one-day

# region: per-crane
# focus: crane_bytes[${${dump:h}:t}]+=bytes
typeset -A crane_bytes
list_dumps | while read -r bytes day dump; do
  (( crane_bytes[${${dump:h}:t}]+=bytes ))
done
print "== KiB per crane for the maintenance planner:"
for crane in ${(ok)crane_bytes}; do
  printf '  %s %4d KiB\n' $crane $(( crane_bytes[$crane] / 1024 ))
done
# endregion: per-crane
