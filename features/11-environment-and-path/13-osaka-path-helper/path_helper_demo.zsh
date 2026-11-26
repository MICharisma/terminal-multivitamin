#!/usr/bin/env zsh
# requires: macos
# Environment and PATH · 13 · Osaka brewery IT loft, reading path_helper's PATH
#
# Teaches:
#   - macOS builds the login PATH with `/usr/libexec/path_helper` from `/etc/paths` and `/etc/paths.d/*`
#   - `path_helper -s` prints shell assignments (`PATH=...; export PATH;`) ready to `eval`
#   - `eval $(path_helper -s)` loads that PATH; then prepend your own bin with the `path` array
#   - Linux has no path_helper; the script exits 2 there and the runner skips it
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "path_helper_demo.zsh uses path_helper, which is a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/suntory-it.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir -p brewery/bin
print -r -- $'#!/bin/sh\necho mash tun ping ok\n' > brewery/bin/mash_ping
chmod +x brewery/bin/mash_ping

# region: path-helper
# focus: /usr/libexec/path_helper -s
print "== path_helper -s:"
/usr/libexec/path_helper -s | while IFS= read -r line; do
  case $line in
    (PATH=*)
      # Count entries without printing machine-specific paths.
      eval $line
      print "  PATH has entries from /etc/paths and /etc/paths.d"
      ;;
    (*) print "  $line" ;;
  esac
done
# endregion: path-helper

# region: eval-helper
# focus: eval $(/usr/libexec/path_helper -s)
eval $(/usr/libexec/path_helper -s)
print "== after eval, command -v ls: $(command -v ls)"
# endregion: eval-helper

# region: prepend-brewery
# focus: path=( $workdir/brewery/bin $path )
path=( $workdir/brewery/bin $path )
print "== after prepending the brewery bin:"
print "  $(command -v mash_ping | sed "s|$workdir|WORK|")"
print "  $(mash_ping)"
# endregion: prepend-brewery
