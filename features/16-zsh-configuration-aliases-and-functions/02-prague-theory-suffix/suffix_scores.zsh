#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 02 · Prague theory-lab suffix aliases
#
# Teaches:
#   - `alias -s ext=command` runs `command file.ext` when you type `file.ext` alone
#   - suffix aliases are per-extension shortcuts for opening lab worksheets
#   - the demo invokes the alias by executing the filename as a command word
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/prague-theory-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p worksheets
print "species counterpoint, species III" > worksheets/bach-invention.pdf
print "figured bass drill" > worksheets/dvorak-bass.ly

# region: suffix-alias
# focus: alias -s
alias -s pdf='print opened-pdf:'
alias -s ly='print opened-lilypond:'
# endregion: suffix-alias

# region: invoke-suffix
# focus: worksheets/bach-invention.pdf
print "== typing a worksheet name opens it via the suffix alias:"
worksheets/bach-invention.pdf
worksheets/dvorak-bass.ly
# endregion: invoke-suffix
