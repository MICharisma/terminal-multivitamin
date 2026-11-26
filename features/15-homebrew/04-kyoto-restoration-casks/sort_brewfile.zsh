#!/usr/bin/env zsh
# Homebrew · 04 · Kyoto print restoration lab casks vs formulae
#
# Teaches:
#   - a Brewfile mixes `brew` formulae (CLI tools) and `cask` apps (GUI)
#   - a `case` router sends each kind to its own packing list for the lab cart
#   - quoting in the Brewfile (`brew "imagemagick"`) is part of the DSL, not the shell
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/kyoto-mokuhanga-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/Brewfile $workdir/
cd -- "$workdir"

mkdir -p packing/{formulae,casks,taps}

# region: case-router
# focus: case $kind in
while IFS= read -r line || [[ -n $line ]]; do
  [[ -z $line || $line == \#* ]] && continue
  kind=${line%% *}
  rest=${line#* }
  name=${rest//\"/}
  case $kind in
    brew) print "$name" >> packing/formulae/cli.txt ;;
    cask) print "$name" >> packing/casks/gui.txt ;;
    tap)  print "$name" >> packing/taps/sources.txt ;;
  esac
done < Brewfile
# endregion: case-router

# region: packing-lists
# focus: packing/formulae/cli.txt
print "== CLI formulae for the scanner Mac:"
cat packing/formulae/cli.txt
print "== GUI casks for the colour desk:"
cat packing/casks/gui.txt
print "== taps:"
cat packing/taps/sources.txt
# endregion: packing-lists
