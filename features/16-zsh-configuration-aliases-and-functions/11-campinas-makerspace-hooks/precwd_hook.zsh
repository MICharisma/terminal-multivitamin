#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 11 · Campinas makerspace hooks
#
# Teaches:
#   - an anonymous function `() { ... }` runs once without leaving a named function
#   - `add-zsh-hook chpwd fn` registers `fn` to run after every directory change
#   - the makerspace uses a chpwd hook to stamp the current project folder
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/campinas-maker-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p projects/{cnc-jig,laser-box}
autoload -Uz add-zsh-hook

# region: anon-setup
# focus: ()
typeset -a visit_log
() {
  visit_log+=( "opened makerspace lobby" )
}
# endregion: anon-setup

# region: register-hook
# focus: add-zsh-hook
stamp_project() {
  visit_log+=( "now in ${PWD#$workdir/}" )
}
add-zsh-hook chpwd stamp_project
# endregion: register-hook

# region: walk
# focus: cd projects/cnc-jig
cd projects/cnc-jig
cd ../laser-box
print "== visit log:"
print -l $visit_log
# endregion: walk
