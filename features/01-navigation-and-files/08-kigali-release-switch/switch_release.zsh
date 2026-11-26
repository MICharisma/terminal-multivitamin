#!/usr/bin/env zsh
# Navigation and files · 08 · Kigali moto-taxi fare app release switch
#
# Teaches:
#   - ln -s makes a "current" symlink that points at one release folder
#   - readlink shows where a symlink points without following it
#   - ln -sfn replaces the link itself; without -n, ln follows the old link
#     into a folder and drops a stray link inside it
#   - rolling back is the same one-line ln -sfn
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/moto-fare-deploy.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for release in 2026-11-24 2026-11-26; do
  mkdir -p releases/$release
  print "fare-api $release" > releases/$release/VERSION
done
print "base fare 300 RWF, 150 RWF per km" > releases/2026-11-24/fares.conf
print "base fare 350 RWF, 160 RWF per km" > releases/2026-11-26/fares.conf

# region: first-link
# focus: ln -s releases/2026-11-24 current
ln -s releases/2026-11-24 current
print "current -> $(readlink current)"
print "serving: $(< current/VERSION), $(< current/fares.conf)"
# endregion: first-link

# region: forgot-n
# focus: ln -sf releases/2026-11-26 current
ln -sf releases/2026-11-26 current
print "== after ln -sf (no -n):"
print "current -> $(readlink current)"
print "stray link inside the old release: $(ls releases/2026-11-24 | grep -c 2026-11-26)"
rm -- releases/2026-11-24/2026-11-26
# endregion: forgot-n

# region: switch-with-n
# focus: ln -sfn releases/2026-11-26 current
ln -sfn releases/2026-11-26 current
print "== after ln -sfn:"
print "current -> $(readlink current)"
print "serving: $(< current/VERSION), $(< current/fares.conf)"
# endregion: switch-with-n

# region: roll-back
# focus: ln -sfn releases/2026-11-24 current
ln -sfn releases/2026-11-24 current
[[ -L current ]] && print "== rolled back; current is still a symlink -> $(readlink current)"
# endregion: roll-back
