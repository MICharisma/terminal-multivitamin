#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 04 · Rabat facilities power audit
#
# Teaches:
#   - `pmset -g` dumps the live power profile (read-only)
#   - awk normalizes the dump to key-present lines so expected output stays stable
#   - nothing calls `pmset` with a write verb
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "power_audit.zsh uses pmset, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/rabat-facilities.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: pmset-read
# focus: pmset -g
pmset -g > pmset-raw.txt
print "pmset -g captured"
# endregion: pmset-read

        # region: awk-keys
        # focus: awk
        # Normalize: only say whether any of the common keys appear; never print values.
        if awk '
          /^[[:space:]]*(sleep|displaysleep|disksleep)[[:space:]]/ { found=1 }
          END { exit !found }
        ' pmset-raw.txt; then
          print "power keys: present"
        else
          print "power keys: absent"
        fi
        # endregion: awk-keys
