#!/usr/bin/env zsh
# Homebrew · 12 · Doha hotel IT cellar and cache paths
#
# Teaches:
#   - `brew --cellar` is where keg versions live under the prefix
#   - `brew --cache` is the download cache Homebrew may reclaim
#   - `print -f` formats a multi-path inventory for the hotel's asset sheet
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/souq-wajif-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH
export HOMEBREW_PREFIX=$workdir/opt/homebrew
export HOMEBREW_CACHE=$workdir/Library/Caches/Homebrew

# region: gather-paths
# focus: brew --cellar
prefix=$(brew --prefix)
cellar=$(brew --cellar)
cache=$(brew --cache)
# endregion: gather-paths

# region: format-sheet
# focus: print -f
print -f '%-8s %s\n' "prefix" "${prefix#$workdir/}"
print -f '%-8s %s\n' "cellar" "${cellar#$workdir/}"
print -f '%-8s %s\n' "cache"  "${cache#$workdir/}"
print -f '%-8s %s\n' "kegs"   "$(print -l $cellar/*(/N:t) | tr '\n' ' ')"
# endregion: format-sheet
