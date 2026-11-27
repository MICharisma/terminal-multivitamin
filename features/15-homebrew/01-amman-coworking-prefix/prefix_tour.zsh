#!/usr/bin/env zsh
# Homebrew · 01 · Amman coworking desk Homebrew prefix
#
# Teaches:
#   - `brew --prefix` prints the Homebrew root (Apple Silicon `/opt/homebrew`, Intel `/usr/local`)
#   - `brew --prefix FORMULA` shows where that formula is or would be installed
#   - checking whether `$PATH` already contains `$prefix/bin` avoids doubling the entry
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/shams-desk-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH
export HOMEBREW_PREFIX=$workdir/opt/homebrew

# region: root-prefix
# focus: brew --prefix
prefix=$(brew --prefix)
print "Homebrew root: ${prefix#$workdir/}"
# endregion: root-prefix

# region: formula-prefix
# focus: brew --prefix ripgrep
rg_prefix=$(brew --prefix ripgrep)
print "ripgrep keg: ${rg_prefix#$workdir/}"
# endregion: formula-prefix

# region: path-membership
# focus: [[ :$PATH: == *:$prefix/bin:* ]]
if [[ :$PATH: == *:$prefix/bin:* ]]; then
  print "PATH already has the Homebrew bin"
else
  print "PATH is missing ${prefix#$workdir/}/bin — add it in .zprofile"
fi
# endregion: path-membership
