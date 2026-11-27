#!/usr/bin/env zsh
# Archives and compression · 09 · Ulaanbaatar core sample archive
#
# Teaches:
#   - `tar -tf` inventories every member before you touch the disk
#   - `tar -xOf` extracts one member to stdout so a geologist can peek without unpacking
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ulaanbaatar-core.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p cores/borehole-14
print "depth 12.0m: pale sandstone, dry"     > cores/borehole-14/sample-12m.txt
print "depth 18.5m: grey mudstone, moist"    > cores/borehole-14/sample-18m.txt
print "depth 24.0m: coal seam lens, brittle" > cores/borehole-14/sample-24m.txt
tar -czf borehole-14.tgz cores/borehole-14
rm -rf cores

# region: list-archive
# focus: tar -tf borehole-14.tgz
print "== borehole-14 members:"
tar -tf borehole-14.tgz | sort
# endregion: list-archive

# region: peek-member
# focus: tar -xOf borehole-14.tgz
member=cores/borehole-14/sample-18m.txt
print "== peek ${member:t} without unpacking:"
tar -xOf borehole-14.tgz $member
# endregion: peek-member

# region: still-packed
# focus: ls -1
print "== workdir still holds only the archive:"
ls -1
# endregion: still-packed
