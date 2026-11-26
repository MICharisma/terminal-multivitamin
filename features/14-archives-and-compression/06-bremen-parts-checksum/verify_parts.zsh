#!/usr/bin/env zsh
# Archives and compression · 06 · Bremen spare-parts checksum
#
# Teaches:
#   - `shasum -a 256` writes a portable SHA-256 digest for each part drawing
#   - `shasum -c` reads the manifest and reports OK or FAILED per line
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/bremen-parts.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p drawings
print "bearing housing, DIN 625, lot B-441" > drawings/housing-b441.dwg
print "shaft sleeve, 28mm, stainless"       > drawings/sleeve-28mm.dwg
print "gasket set, viton, revision C"       > drawings/gasket-viton.dwg

# region: write-manifest
# focus: shasum -a 256
: > SHA256SUMS
for drawing in drawings/gasket-viton.dwg drawings/housing-b441.dwg drawings/sleeve-28mm.dwg; do
  shasum -a 256 $drawing >> SHA256SUMS
done
print "== sealed drawings:"
awk '{print $2}' SHA256SUMS
# endregion: write-manifest

# region: verify-ok
# focus: shasum -c SHA256SUMS
print "== verify intact:"
shasum -c SHA256SUMS
# endregion: verify-ok

# region: detect-tamper
# focus: shasum -c
print "altered gasket, unsigned rewrite" > drawings/gasket-viton.dwg
print "== verify after a quiet edit:"
shasum -c SHA256SUMS 2>/dev/null || true
# endregion: detect-tamper
