#!/usr/bin/env zsh
# Archives and compression · 08 · Recife carnival office update
#
# Teaches:
#   - `zip` adds the first wave of office files to a new archive
#   - a `while read` plan feeds `zip -u`, which refreshes only the changed members
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/recife-carnival.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p office
print "bloco: Galo da Madrugada, departure 05:00" > office/route-galo.txt
print "sound: trio eléctrico A, volume limit 110 dB" > office/sound-trio-a.txt
print "float: rainha do mar, height 8m"             > office/float-rainha.txt

# region: seed-zip
# focus: zip carnival-desk.zip
zip carnival-desk.zip office/route-galo.txt office/sound-trio-a.txt office/float-rainha.txt >/dev/null
print "== seeded carnival-desk.zip"
# endregion: seed-zip

print "office/route-galo.txt"  > refresh.plan
print "office/float-rainha.txt" >> refresh.plan
print "bloco: Galo da Madrugada, departure 04:45 (tide)" > office/route-galo.txt
print "float: rainha do mar, height 8m, LED crown"      > office/float-rainha.txt
# zip -u compares mtimes; stamp the rewritten notes so they count as newer.
touch -t 203001011200 office/route-galo.txt office/float-rainha.txt

# region: update-members
# focus: zip -u carnival-desk.zip
print "== updating from refresh.plan:"
while IFS= read -r member; do
  zip -u carnival-desk.zip $member >/dev/null
  print "  refreshed ${member:t}"
done < refresh.plan
# endregion: update-members

# region: show-updated
# focus: unzip -p
print "== route after update:"
unzip -p carnival-desk.zip office/route-galo.txt
print "== float after update:"
unzip -p carnival-desk.zip office/float-rainha.txt
# endregion: show-updated
