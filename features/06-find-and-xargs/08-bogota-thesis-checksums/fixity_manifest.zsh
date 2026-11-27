#!/usr/bin/env zsh
# Finding files with find and xargs · 08 · Bogotá university library, fixity checksums for the thesis repository
#
# Teaches:
#   - `xargs -n 4` caps each command at four arguments, so ten theses take three runs
#   - `xargs -P 3` runs up to three commands at once; their output arrives in any order,
#     so sort it before you save it
#   - `cksum` prints the same POSIX CRC, size and name on macOS and Linux, which makes it
#     a portable fixity check
#   - with no input, GNU `xargs` still runs `cksum` once (which then checksums an empty stdin)
#     unless given `-r`; BSD `xargs` never runs on empty input, so add `-r` only where it is accepted
#   - comparing two sorted manifests with `diff` names the one file that changed
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/biblioteca-tesis.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for thesis in ingenieria/2025-restrepo ingenieria/2025-quintero ingenieria/2026-vargas \
              medicina/2025-ospina medicina/2026-cardenas medicina/2026-mejia \
              artes/2025-rincon artes/2026-gaitan artes/2026-castano artes/2026-pardo; do
  mkdir -p tesis/${thesis:h}
  print "Universidad, Facultad de ${thesis:h}, tesis de grado de ${thesis:t}" > tesis/$thesis.pdf
done

# region: batches
# focus: xargs -0 -n 4 echo
print "== xargs -n 4 over ten theses:"
find tesis -name '*.pdf' -print0 | xargs -0 -n 4 echo | while read -rA batch; do
  print "  one cksum run would get $#batch files"
done
# endregion: batches

# region: parallel
# focus: xargs -0 -n 2 -P 3 cksum
manifest() {
  find tesis -name '*.pdf' -print0 | xargs -0 -n 2 -P 3 cksum | sort -k 3
}
manifest > manifest-2026-11.txt
print "manifest lines: $(( $(wc -l < manifest-2026-11.txt) ))"
print "== first entries, crc, bytes, path:"
head -n 3 manifest-2026-11.txt
# endregion: parallel

# region: empty-input
# focus: xargs_cmd+=( -r )
xargs_cmd=( xargs -0 )
if xargs -r true < /dev/null 2>/dev/null; then
  xargs_cmd+=( -r )
fi
mkdir -p tesis/derecho
lines=$(find tesis/derecho -name '*.pdf' -print0 | $xargs_cmd cksum | wc -l)
print "derecho has deposited nothing yet: $(( lines )) manifest lines, not a checksum of empty input"
# endregion: empty-input

# region: verify
# focus: diff manifest-2026-11.txt manifest-check.txt
print "corrected abstract" >> tesis/medicina/2026-mejia.pdf
manifest > manifest-check.txt
diff manifest-2026-11.txt manifest-check.txt > fixity.diff || print "== changed since the deposit:"
sed -n 's/^> [0-9]* [0-9]* /  /p' fixity.diff
# endregion: verify
