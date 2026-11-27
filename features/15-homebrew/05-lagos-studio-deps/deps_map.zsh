#!/usr/bin/env zsh
# Homebrew · 05 · Lagos highlife studio dependency map
#
# Teaches:
#   - `brew deps FORMULA` lists what that formula needs
#   - `brew uses FORMULA` lists installed formulae that pull it in
#   - an associative array (`typeset -A`) holds the dependency map for a studio machine
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/afrobeats-studio-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

typeset -A deps_of uses_of

# region: deps-map
# focus: brew deps
for formula in ffmpeg sox lame; do
  deps_of[$formula]=$(brew deps $formula | tr '\n' ' ')
done
# endregion: deps-map

# region: uses-map
# focus: brew uses
for library in lame libogg; do
  uses_of[$library]=$(brew uses --installed $library | tr '\n' ' ')
done
# endregion: uses-map

# region: print-table
# focus: deps_of[$formula]
print "== what each studio tool needs:"
for formula in ffmpeg sox lame; do
  print "  $formula -> ${deps_of[$formula]}"
done
print "== who pulls in the shared libraries:"
for library in lame libogg; do
  print "  $library <- ${uses_of[$library]}"
done
# endregion: print-table
