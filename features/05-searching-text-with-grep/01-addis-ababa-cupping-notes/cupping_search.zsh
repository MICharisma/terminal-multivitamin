#!/usr/bin/env zsh
# Searching text with grep · 01 · Addis Ababa coffee exchange, searching the cupping notes
#
# Teaches:
#   - `grep pattern file` prints every line that contains the pattern
#   - `grep -c` counts matching lines; exit status is 0 on a match, 1 on none (with `|| true` under `errexit`)
#   - without `-F` or `-E`, basic regex treats `.` as "any character": `86.` matches `86.5` and `86`
#   - quote the pattern so the shell does not expand `*` or `?` before grep sees them
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/ecxe-cupping.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/cupping-day.txt $workdir/
cd -- "$workdir"

# region: plain-search
# focus: grep Yirgacheffe cupping-day.txt
print "== Yirgacheffe lots for the Hamburg roaster:"
grep Yirgacheffe cupping-day.txt
# endregion: plain-search

# region: count
# focus: grep -c 'acidity bright' cupping-day.txt
print "lots with bright acidity: $(grep -c 'acidity bright' cupping-day.txt)"
# endregion: count

# region: basic-dot
# focus: grep 'score 86.' cupping-day.txt
print "== score 86. in basic regex (. matches any character):"
grep 'score 86.' cupping-day.txt
# endregion: basic-dot

# region: quoted-star
# focus: grep 'fragrance floral' cupping-day.txt
print "== quoted pattern, shell leaves it alone:"
grep 'fragrance floral' cupping-day.txt
if ! grep 'no-such-origin' cupping-day.txt > /dev/null; then
  print "no match: grep exits 1 (caught with if ! so errexit stays happy)"
fi
# endregion: quoted-star
