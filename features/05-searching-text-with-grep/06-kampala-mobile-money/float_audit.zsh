#!/usr/bin/env zsh
# Searching text with grep · 06 · Kampala mobile-money agents, auditing the morning float
#
# Teaches:
#   - `grep -r pattern dir` searches every file under a folder (GNU and BSD both support `-r`)
#   - `grep -l` lists only the file names that matched; `grep -L` lists the ones that did not
#   - `-r` prefixes each hit with `file:`; `-h` hides the filename when you want bare lines
#   - recursive grep follows the tree; keep the folder small, or prefer `rg` for big trees
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/mtn-float-kampala.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/ledger $workdir/
cd -- "$workdir"

# region: recursive
# focus: grep -r FAILED ledger | sort
print "== FAILED transactions across all agents:"
grep -r FAILED ledger | sort
# endregion: recursive

# region: files-with
# focus: grep -rl FAILED ledger | sort
print "== agents that saw a failure:"
grep -rl FAILED ledger | sort
# endregion: files-with

# region: files-without
# focus: grep -rL FAILED ledger | sort
print "== agents with a clean morning:"
grep -rL FAILED ledger | sort
# endregion: files-without

# region: hide-names
# focus: grep -rh '0772-441-220' ledger
print "== every touch of 0772-441-220, bare lines for the spreadsheet:"
grep -rh '0772-441-220' ledger | sort
# endregion: hide-names
