#!/usr/bin/env zsh
# requires: macos
# Archives and compression · 12 · Fukuoka score zip
#
# Teaches:
#   - `ditto -c -k` builds a Finder-friendly zip from a folder tree
#   - `ditto -x -k` extracts that zip back; Terminal listing confirms the scores
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "ditto_scores.zsh uses ditto, which is a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/fukuoka-scores.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p repertoire/shamisen repertoire/koto
print "Sakura sakura, shamisen part A" > repertoire/shamisen/sakura-a.mscz
print "Sakura sakura, koto ostinato"   > repertoire/koto/sakura-ostinato.mscz
print "Kuroda-bushi, ensemble cue"    > repertoire/kuroda-bushi.mscz

# region: ditto-zip
# focus: ditto -c -k
# --keepParent keeps the repertoire/ folder at the top of the zip (default
# ditto archives only the directory's contents).
ditto -c -k --keepParent repertoire repertoire.zip
print "== packed repertoire.zip with ditto"
# endregion: ditto-zip

# region: ditto-extract
# focus: ditto -x -k
mkdir -p restored
ditto -x -k repertoire.zip restored
print "== restored scores:"
for score in restored/repertoire/koto/sakura-ostinato.mscz \
             restored/repertoire/kuroda-bushi.mscz \
             restored/repertoire/shamisen/sakura-a.mscz; do
  [[ -f $score ]] && print "  $score"
done
# endregion: ditto-extract
