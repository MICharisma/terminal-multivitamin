#!/usr/bin/env zsh
# ssh, scp, and rsync · 12 · Osaka score library mirror
#
# Teaches:
#   - `rsync --delete -av` makes the destination match the source, removing extras
#   - a before/after listing shows which stale score disappeared
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/kansai-scores.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -R -- ${0:A:h}/fixtures/library/current ${0:A:h}/fixtures/library/stale-copy .
mkdir -p mirror
rsync -a stale-copy/ mirror/

# region: before-mirror
# focus: ls -1 mirror
print "== mirror before:"
ls -1 mirror
# endregion: before-mirror

# region: delete-stale
# focus: rsync --delete
rsync --delete -av current/ mirror/ | awk '
  /^sent / { next }
  /^total size/ { next }
  NF { print }
' | while IFS= read -r line; do
  print "rsync: $line"
done
# endregion: delete-stale

# region: after-mirror
# focus: ls -1 mirror
print "== mirror after:"
ls -1 mirror
# endregion: after-mirror
