#!/usr/bin/env zsh
# Archives and compression · 03 · Busan shipping documents
#
# Teaches:
#   - `zip -r` packs a whole folder tree into a zip archive
#   - `unzip` restores the tree; comparing content before and after proves the roundtrip
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/busan-manifest.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p shipment/bills shipment/certs
print "BL-88421: Hyundai Glovis, Busan → Rotterdam, 40ft" > shipment/bills/bl-88421.txt
print "COO: origin Republic of Korea, steel coils"       > shipment/certs/coo-steel.txt
print "phytosanitary: not applicable, dry cargo"         > shipment/certs/phyto-na.txt

# region: before-hash
# focus: shasum -a 256
print "== before zip:"
before=$(shasum -a 256 shipment/bills/bl-88421.txt | awk '{print $1}')
print "bl-88421 sha256: $before"
# endregion: before-hash

# region: zip-tree
# focus: zip -r shipment.zip shipment
zip -r shipment.zip shipment >/dev/null
rm -rf shipment
print "== packed shipment.zip"
# endregion: zip-tree

# region: unzip-back
# focus: unzip -q shipment.zip
unzip -q shipment.zip
after=$(shasum -a 256 shipment/bills/bl-88421.txt | awk '{print $1}')
print "== after unzip:"
print "bl-88421 sha256: $after"
if [[ $before == $after ]]; then
  print "roundtrip: match"
else
  print "roundtrip: mismatch"
fi
print "bills: $(ls -1 shipment/bills)"
print "certs: $(ls -1 shipment/certs | paste -sd' ' -)"
# endregion: unzip-back
