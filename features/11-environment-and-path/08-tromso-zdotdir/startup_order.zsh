#!/usr/bin/env zsh
# Environment and PATH · 08 · Tromsø northern lights desk, watching zsh startup files under ZDOTDIR
#
# Teaches:
#   - `ZDOTDIR` relocates `.zshenv`, `.zprofile`, `.zshrc`, `.zlogin` for a clean experiment
#   - `.zshenv` runs for every zsh; `.zprofile` for login shells; `.zshrc` for interactive shells
#   - `zsh -f` skips all of them; `zsh -i` is interactive; `zsh -l` is login
#   - put PATH exports in `.zshenv` only if every script should see them; prefer `.zprofile` for login PATH
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tromso-aurora.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir zdot
print 'print "[zshenv] PATH seed"' > zdot/.zshenv
print 'print "[zprofile] login PATH"' > zdot/.zprofile
print 'print "[zshrc] interactive"' > zdot/.zshrc
print 'print "[zlogin] login welcome"' > zdot/.zlogin

run() {
  local label=$1; shift
  print "== $label:"
  # Keep only our markers: Ubuntu's /etc/zsh/zshrc may print compinit noise
  # when zsh -i has no terminal.
  ZDOTDIR=$workdir/zdot "$@" 2>&1 |
    grep -E '^(\[(zshenv|zprofile|zshrc|zlogin)\]|done)' |
    sed 's/^/  /'
}

# region: every-shell
# focus: zsh -c
run "zsh -c (every shell: zshenv only)" zsh -c 'print done'
# endregion: every-shell

# region: interactive
# focus: zsh -i -c
run "zsh -i -c (interactive: zshenv + zshrc)" zsh -i -c 'print done'
# endregion: interactive

# region: login
# focus: zsh -l -c
run "zsh -l -c (login: zshenv + zprofile + zlogin)" zsh -l -c 'print done'
# endregion: login

# region: login-interactive
# focus: zsh -il -c
run "zsh -il -c (login interactive: all four)" zsh -il -c 'print done'
# endregion: login-interactive
