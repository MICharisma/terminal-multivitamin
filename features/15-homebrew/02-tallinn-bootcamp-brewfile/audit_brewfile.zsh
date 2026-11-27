#!/usr/bin/env zsh
# Homebrew · 02 · Tallinn coding bootcamp Brewfile audit
#
# Teaches:
#   - a `Brewfile` declares taps, formulae, and casks as plain lines of Ruby DSL
#   - `while IFS= read -r` walks each line without splitting on spaces inside quotes
#   - classifying lines lets the desk count what a cohort laptop still needs
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/kood-johvi-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/Brewfile $workdir/
cd -- "$workdir"

typeset -i taps=0 formulae=0 casks=0 skipped=0

# region: read-brewfile
# focus: while IFS= read -r line
while IFS= read -r line || [[ -n $line ]]; do
  [[ -z $line || $line == \#* ]] && { skipped=$(( skipped + 1 )); continue }
  # endregion: read-brewfile
  # region: classify-lines
  # focus: case $line in
  case $line in
    tap\ *)   taps=$(( taps + 1 )); print "tap:     ${line#tap }" ;;
    brew\ *)  formulae=$(( formulae + 1 )); print "formula: ${line#brew }" ;;
    cask\ *)  casks=$(( casks + 1 )); print "cask:    ${line#cask }" ;;
    *)        print "other:   $line" ;;
  esac
  # endregion: classify-lines
done < Brewfile

print "== cohort laptop still needs: $taps taps, $formulae formulae, $casks casks ($skipped comments/blank)"
