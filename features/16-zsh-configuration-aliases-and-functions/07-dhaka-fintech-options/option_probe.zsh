#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 07 · Dhaka fintech option probe
#
# Teaches:
#   - `setopt` turns an option on; `unsetopt` turns it off
#   - `[[ -o name ]]` tests whether an option is currently set
#   - a fintech desk probes interactive conveniences before enabling them in CI shells
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dhaka-fintech-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

probe() {
  local opt=$1
  if [[ -o $opt ]]; then
    print "$opt: on"
  else
    print "$opt: off"
  fi
}

# region: baseline
# focus: probe interactive
print "== baseline on the build agent:"
probe interactive
probe monitor
probe null_glob
# endregion: baseline

# region: setopt-toggle
# focus: setopt
setopt null_glob
print "== after setopt null_glob:"
probe null_glob
# endregion: setopt-toggle

# region: unsetopt-toggle
# focus: unsetopt
unsetopt null_glob
print "== after unsetopt null_glob:"
probe null_glob
# endregion: unsetopt-toggle
