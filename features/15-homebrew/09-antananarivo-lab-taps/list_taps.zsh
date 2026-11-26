#!/usr/bin/env zsh
# Homebrew · 09 · Antananarivo CS lab taps
#
# Teaches:
#   - `brew tap` with no arguments lists every tapped repository
#   - a Brewfile's `tap "..."` lines name third-party sources the lab relies on
#   - `${(u)array}` uniques the combined list so imaging scripts do not retap
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/univ-antananarivo-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: brew-tap
# focus: brew tap
installed_taps=( ${(f)"$(brew tap)"} )
print "== already tapped on the lab iMac:"
print -l $installed_taps
# endregion: brew-tap

# region: brewfile-taps
# focus: brewfile_taps
typeset -a brewfile_taps
while IFS= read -r line || [[ -n $line ]]; do
  [[ $line == tap\ * ]] || continue
  name=${line#tap }
  name=${name//\"/}
  brewfile_taps+=( $name )
done < Brewfile
print "== taps declared in the lab Brewfile:"
print -l $brewfile_taps
# endregion: brewfile-taps

# region: unique-union
# focus: ${(u)all_taps}
all_taps=( $installed_taps $brewfile_taps )
print "== unique taps after imaging:"
print -l ${(u)all_taps}
# endregion: unique-union
