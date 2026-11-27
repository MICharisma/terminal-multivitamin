#!/usr/bin/env zsh
# ssh, scp, and rsync · 07 · Bogotá Contadoría invoice exclude
#
# Teaches:
#   - `rsync --exclude` skips matching files or folders during a sync
#   - a `case` router picks the exclude pattern for each kind of clutter
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/contadoria-facturas.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -R -- ${0:A:h}/fixtures/facturas ${0:A:h}/fixtures/borradores .
mkdir -p escritorio-remoto

# region: choose-excludes
# focus: case $clutter in
typeset -a excludes
for clutter in tmp-files drafts; do
  case $clutter in
    (tmp-files) excludes+=('--exclude' '*.tmp') ;;
    (drafts)    excludes+=('--exclude' 'borradores/') ;;
  esac
done
print "== excludes:" ${(j: :)excludes}
# endregion: choose-excludes

# region: sync-clean
# focus: "${excludes[@]}"
rsync -a "${excludes[@]}" --exclude 'escritorio-remoto/' ./ escritorio-remoto/
# endregion: sync-clean

# region: remote-desk
# focus: ls -1R escritorio-remoto
print "== escritorio-remoto:"
ls -1R escritorio-remoto
# endregion: remote-desk
