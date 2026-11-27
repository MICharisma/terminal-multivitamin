#!/usr/bin/env zsh
# Archives and compression · 01 · Palermo festa birthday photos
#
# Teaches:
#   - `tar -czf` packs named files into a gzipped archive in one shot
#   - `tar -tf` lists member names only (no dates or owners that vary by machine)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/festa-rossi.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p album
print "Nonna Maria cutting the cassata, courtyard lights on" > album/nonna-maria.jpg
print "Zio Paolo with the fireworks sparklers"              > album/zio-paolo.jpg
print "The whole table after the toast"                    > album/tavolata.jpg

# region: pack-album
# focus: tar -czf festa-2026.tgz
tar -czf festa-2026.tgz album/nonna-maria.jpg album/zio-paolo.jpg album/tavolata.jpg
print "== packed festa-2026.tgz"
# endregion: pack-album

# region: list-members
# focus: tar -tf festa-2026.tgz
print "== members:"
tar -tf festa-2026.tgz | sort
# endregion: list-members
