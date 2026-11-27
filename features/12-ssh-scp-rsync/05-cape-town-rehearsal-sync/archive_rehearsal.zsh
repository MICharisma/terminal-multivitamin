#!/usr/bin/env zsh
# ssh, scp, and rsync · 05 · Cape Town Baxter Theatre rehearsal sync
#
# Teaches:
#   - `rsync -av` mirrors a folder tree while keeping permissions and times
#   - a trailing slash on the source copies the *contents* into the destination
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/baxter-rehearsal.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -R -- ${0:A:h}/fixtures/rehearsal .
mkdir -p archive/week-47

# region: source-takes
# focus: ls -1 rehearsal/act-1
print "== rehearsal takes:"
ls -1 rehearsal/act-1
# endregion: source-takes

# region: rsync-archive
# focus: rsync -av
summary=$(rsync -av rehearsal/act-1/ archive/week-47/ | awk '
  /^sent / { next }
  /^total size/ { next }
  NF { print }
')
print "== rsync:"
print -r -- "$summary"
# endregion: rsync-archive

# region: archive-listing
# focus: ls -1 archive/week-47
print "== archive/week-47:"
ls -1 archive/week-47
# endregion: archive-listing
