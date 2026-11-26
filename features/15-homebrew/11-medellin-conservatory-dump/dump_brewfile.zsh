#!/usr/bin/env zsh
# Homebrew · 11 · Medellín conservatory Brewfile dump
#
# Teaches:
#   - `brew bundle dump --file PATH --force` writes a Brewfile from what is installed
#   - dumping into the temp folder keeps the repo's committed Brewfile untouched
#   - `diff` shows drift between the committed file and the live machine
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/eafit-conservatory-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: dump-live
# focus: brew bundle dump
brew bundle dump --file $workdir/Brewfile.live --force
print "dumped live Brewfile: $(wc -l < Brewfile.live | tr -d ' ') lines"
# endregion: dump-live

# region: diff-committed
# focus: diff -u --label Brewfile
print "== drift vs committed Brewfile:"
diff -u --label Brewfile --label Brewfile.live Brewfile Brewfile.live || print "(no drift)"
# endregion: diff-committed
