#!/usr/bin/env zsh
# ssh, scp, and rsync · 06 · Lyon CNC shop dry-run
#
# Teaches:
#   - `rsync --dry-run -av` shows what would transfer without writing anything
#   - a plan file plus `while IFS= read -r` feeds the paths one at a time
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/atelier-cnc.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -R -- ${0:A:h}/fixtures/programmes .
mkdir -p machine-share
print -l programmes/fraise-402.nc programmes/tour-alu-18.nc > transfer-plan.txt

# region: empty-share
# focus: ls -1 machine-share
print "== machine-share before:"
ls -1 machine-share || true
# endregion: empty-share

# region: dry-run-plan
# focus: rsync --dry-run
print "== dry-run:"
while IFS= read -r programme; do
  rsync --dry-run -av $programme machine-share/ | awk '
    /^sent / { next }
    /^total size/ { next }
    /^sending / { next }
    NF { print }
  '
done < transfer-plan.txt
# endregion: dry-run-plan

# region: still-empty
# focus: ls -1 machine-share
print "== machine-share after dry-run:"
ls -1 machine-share || true
# endregion: still-empty
