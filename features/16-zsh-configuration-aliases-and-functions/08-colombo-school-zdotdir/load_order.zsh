#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 08 · Colombo school ZDOTDIR load order
#
# Teaches:
#   - `ZDOTDIR` relocates `.zshenv`, `.zprofile`, `.zshrc`, and `.zlogin` away from `$HOME`
#   - login+interactive zsh sources them in a fixed order
#   - a school laptop image can ship one ZDOTDIR tree without touching students' real homes
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/colombo-school-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
zdot=$workdir/zdot
mkdir -p $zdot

# region: write-startup
# focus: print "1 .zshenv"
print 'print "1 .zshenv"'   > $zdot/.zshenv
print 'print "2 .zprofile"' > $zdot/.zprofile
print 'print "3 .zshrc"'    > $zdot/.zshrc
print 'print "4 .zlogin"'   > $zdot/.zlogin
# endregion: write-startup

# region: login-interactive
# focus: ZDOTDIR
print "== load order for login+interactive:"
ZDOTDIR=$zdot zsh -ilc 'print "5 -c body"'
# endregion: login-interactive
