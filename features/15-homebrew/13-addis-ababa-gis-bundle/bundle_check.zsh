#!/usr/bin/env zsh
# Homebrew · 13 · Addis Ababa GIS desk bundle check
#
# Teaches:
#   - `brew bundle check --verbose` reports missing Brewfile dependencies without installing
#   - `brew bundle list` names what the Brewfile declares
#   - an anonymous function `() { ... }` scopes the check and prints a desk summary
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/ema-gis-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: list-declared
# focus: brew bundle list
print "== Brewfile declares:"
brew bundle list --brews --casks --taps
# endregion: list-declared

# region: check-verbose
# focus: brew bundle check
() {
  emulate -L zsh
  local report
  if report=$(brew bundle check --verbose --file Brewfile 2>&1); then
    print "bundle check: satisfied"
  else
    print "bundle check: gaps remain"
    print "$report"
  fi
}
# endregion: check-verbose

# region: anon-summary
# focus: ()
() {
  print "== desk action: install only the missing formulae on the GIS laptop"
  print "   (this example stops before any install)"
}
# endregion: anon-summary
