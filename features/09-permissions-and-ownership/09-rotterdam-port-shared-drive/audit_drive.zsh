#!/usr/bin/env zsh
# Permissions and ownership · 09 · Port of Rotterdam planning office, auditing a shared drive
#
# Teaches:
#   - `find -perm -0002` matches files with *at least* those bits (here: others may write)
#   - combining tests: world-writable folders without the sticky bit are `-perm -0002 ! -perm -1000`
#   - "any of these bits" is `-perm /022` in GNU find and `-perm +022` in old BSD find;
#     `\( -perm -0020 -o -perm -0002 \)` works in both
#   - `-exec chmod o-w {} +` fixes everything found in a few `chmod` calls, not one per file
#   - `find` lists in directory order, so `sort` the report before comparing it
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/havenbedrijf-audit.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p planning/{ligplaatsen,loodsen,scans-usb} planning/inbox
print "Maasvlakte 2, kade 7: Maersk Elba, ETA 06:40" > planning/ligplaatsen/week-48.csv
print "Euromax, kade 3: CMA CGM Jacques Saade, ETA 11:15" > planning/ligplaatsen/week-49.csv
print "loods 4: 14 loodsen ingeroosterd, nacht" > planning/loodsen/rooster.txt
for scan in douane-verklaring_0412 douane-verklaring_0413; do
  print "scan $scan" > planning/scans-usb/$scan.pdf
done
print "drop files here for the morning meeting" > planning/inbox/LEESMIJ.txt
chmod 666 planning/ligplaatsen/week-49.csv
chmod 664 planning/loodsen/rooster.txt
chmod 777 planning/scans-usb planning/scans-usb/*.pdf
chmod 1777 planning/inbox

# region: world-writable-files
# focus: find planning -type f -perm -0002
print "== files anyone can change:"
find planning -type f -perm -0002 | sort
# endregion: world-writable-files

# region: unsticky-folders
# focus: -perm -0002 ! -perm -1000
print "== world-writable folders without the sticky bit (anyone can delete anyone's file):"
find planning -type d -perm -0002 ! -perm -1000 | sort
# endregion: unsticky-folders

# region: any-of-bits
# focus: \( -perm -0020 -o -perm -0002 \)
print "== group- or world-writable files (portable 'any of these bits'):"
find planning -type f \( -perm -0020 -o -perm -0002 \) | sort
print "== executable PDFs, a sign they came off a FAT-formatted USB stick:"
find planning -type f -name '*.pdf' -perm -0100 | sort
# endregion: any-of-bits

# region: bulk-fix
# focus: -exec chmod o-w,a-x {} +
find planning -type f \( -perm -0002 -o -perm -0100 \) -exec chmod o-w,a-x {} +
find planning -type d -perm -0002 ! -perm -1000 -exec chmod o-w {} +
print "== after the fix:"
print "  world-writable files: $(( $(find planning -type f -perm -0002 | wc -l) ))"
print "  unsticky world-writable folders: $(( $(find planning -type d -perm -0002 ! -perm -1000 | wc -l) ))"
print "  inbox kept its sticky bit: $(ls -ld planning/inbox | cut -c1-10)"
# endregion: bulk-fix
