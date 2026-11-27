#!/usr/bin/env zsh
# Sorting, counting, and columns · 01 · Lisbon pastelaria, tallying the 23 December orders
#
# Teaches:
#   - `uniq -c` only merges neighbouring lines, so it needs `sort` in front of it
#   - `sort | uniq -c | sort -rn` ranks items by how often they occur
#   - `uniq -c` pads its counts to different widths on BSD and GNU; `read -r count item`
#     drops the padding so `printf` can set its own
#   - `sort -rn` leaves equal counts to sort's last-resort rule (GNU reverses that too);
#     `sort -k1,1nr -k2,2` ranks by count and then breaks ties alphabetically, everywhere
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pastelaria-belem.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/orders-2026-12-23.txt $workdir/
cd -- "$workdir"

# region: unsorted-uniq
# focus: uniq -c orders-2026-12-23.txt
print "uniq -c without sort: $(uniq -c orders-2026-12-23.txt | wc -l | tr -d ' ') lines for $(sort -u orders-2026-12-23.txt | wc -l | tr -d ' ') kinds of cake"
# endregion: unsorted-uniq

# region: tally
# focus: sort orders-2026-12-23.txt | uniq -c
print "== orders per cake for the bakers:"
sort orders-2026-12-23.txt | uniq -c | while read -r count cake; do
  printf '%3d %s\n' $count $cake
done
# endregion: tally

# region: rank
# focus: sort -rn
read -r count cake < <(sort orders-2026-12-23.txt | uniq -c | sort -rn | head -n 1)
print "best seller: $cake, $count orders"
# endregion: rank

# region: tie-break
# focus: sort -k1,1nr -k2,2
print "== ranked by count, ties in alphabetical order, for the shop window board:"
sort orders-2026-12-23.txt | uniq -c | sort -k1,1nr -k2,2 | while read -r count cake; do
  printf '%3d %s\n' $count $cake
done
# endregion: tie-break
