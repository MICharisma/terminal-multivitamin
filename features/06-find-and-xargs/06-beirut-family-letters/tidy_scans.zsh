#!/usr/bin/env zsh
# Finding files with find and xargs · 06 · Beirut family, tidying the scans of Teta's letters
#
# Teaches:
#   - `-exec sh -c '...' sh {} +` hands a batch of names to a small shell script, which loops
#     over them with `for scan do`
#   - the word after the script (`sh`) becomes `$0`; leave it out and the first file is lost
#     into `$0`
#   - `-execdir` runs the command inside each file's folder; GNU passes `./name` and BSD passes
#     `name`, so strip the prefix with `${1#./}`
#   - test `[ -e "$target" ]` before `mv`: when two scans clean up to one name, GNU `mv -n`
#     exits with an error and BSD `mv -n` stays quiet, so neither is a portable signal
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/rasael-teta.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p rasael/{1975,1982,1990}
for scan in 1975/from-salim-in-paris.JPEG 1975/from-salim-in-paris.jpg 1982/wedding-invitation.jpeg \
            1982/from-mona-in-montreal.JPG 1990/postcard-from-byblos.jpg; do
  print "scan, 600 dpi, from Teta's box in Achrafieh" > rasael/$scan
done

# region: count-arguments
# focus: sh -c 'echo "$#"' sh {} +
print "scans handed over with sh as \$0: $(find rasael -type f -exec sh -c 'echo "$#"' sh {} +)"
print "scans handed over without it:    $(find rasael -type f -exec sh -c 'echo "$#"' {} +)"
# endregion: count-arguments

# region: rename-batch
# focus: -exec sh -c '
find rasael -type f \( -name '*.JPEG' -o -name '*.jpeg' -o -name '*.JPG' \) -exec sh -c '
  for scan do
    target=${scan%.*}.jpg
    if [ -e "$target" ]; then
      echo "kept $scan: $target is already there"
    else
      mv -- "$scan" "$target"
    fi
  done
' sh {} +
print "== after renaming:"
find rasael -type f | sort
# endregion: rename-batch

# region: execdir-captions
# focus: -execdir sh -c
find rasael -name '*.jpg' -execdir sh -c '
  scan=${1#./}
  echo "$scan, from the family archive" > "${scan%.jpg}.txt"
' sh {} \;
print "== captions written next to each scan, by name only:"
cat rasael/1990/*.txt
# endregion: execdir-captions
