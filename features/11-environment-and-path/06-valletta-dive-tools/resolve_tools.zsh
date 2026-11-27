#!/usr/bin/env zsh
# Environment and PATH · 06 · Valletta dive school, asking the shell where each tool is
#
# Teaches:
#   - `command -v name` is the portable "does it exist, and where?"
#   - `whence -v` (zsh) says whether it is an alias, function, builtin, or executable
#   - `type -a` lists every match on PATH, not just the first
#   - `which` is common but not POSIX; prefer `command -v` in scripts
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/divewise-valletta.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p bin
print -r -- $'#!/bin/sh\necho nitrox mix 32%\n' > bin/nitrox_mix
chmod +x bin/nitrox_mix
path=( $workdir/bin $path )
alias tanks='print 12 L steel'

# region: command-v
# focus: command -v nitrox_mix
print "== command -v:"
print "  nitrox_mix -> $(command -v nitrox_mix | sed "s|$workdir|WORK|")"
print "  tanks      -> $(command -v tanks)"
print "  cd         -> $(command -v cd)"
# endregion: command-v

# region: whence-v
# focus: whence -v
print "== whence -v:"
whence -v nitrox_mix tanks cd | sed "s|$workdir|WORK|; s/^/  /"
# endregion: whence-v

# region: type-a
# focus: type -a
print -r -- $'#!/bin/sh\necho shadow\n' > bin/ls
chmod +x bin/ls
print "== type -a ls (lab bin shadows the system):"
type -a ls | sed "s|$workdir|WORK|; s/^/  /"
# endregion: type-a

# region: which
# focus: which nitrox_mix
print "== which (handy interactively):"
which nitrox_mix | sed "s|$workdir|WORK|; s/^/  /"
# endregion: which
