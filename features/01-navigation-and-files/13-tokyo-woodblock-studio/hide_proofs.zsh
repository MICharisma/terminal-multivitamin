#!/usr/bin/env zsh
# requires: macos
# Navigation and files · 13 · Tokyo woodblock print studio, tidying before a client call
#
# Teaches:
#   - `chflags hidden` hides a folder from Finder without renaming it; `ls -lO` shows the flag
#   - Terminal still sees hidden folders: `ls` lists them, `cd` enters them
#   - `xattr -w` / `-p` / `-d` attach, read, and remove extended attributes on a file
#   - `cp` keeps extended attributes on macOS; `cp -X` leaves them behind
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "hide_proofs.zsh uses chflags and xattr, which are macOS tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/mokuhanga-studio.XXXXXX")
trap 'chflags -R nohidden "$workdir" 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p series-fuji-36/proofs series-fuji-36/final
print "key block proof, state 2, too much bokashi on the sky" > series-fuji-36/proofs/kanagawa_state-2.txt
print "final impression 14/50"                                > series-fuji-36/final/kanagawa_14-of-50.txt

flags_of() { ls -ldO -- $1 | grep -q hidden && print hidden || print visible }

# region: hide-folder
# focus: chflags hidden series-fuji-36/proofs
chflags hidden series-fuji-36/proofs
print "proofs in Finder: $(flags_of series-fuji-36/proofs)"
print "final in Finder:  $(flags_of series-fuji-36/final)"
# endregion: hide-folder

# region: terminal-still-sees
# focus: ls -1 series-fuji-36
print "== ls still lists both:"
ls -1 series-fuji-36
cd series-fuji-36/proofs && print "cd into the hidden folder: ok" && cd -- "$workdir"
# endregion: terminal-still-sees

# region: tag-print
# focus: xattr -w jp.mokuhanga.printer "Watanabe Keiko"
final=series-fuji-36/final/kanagawa_14-of-50.txt
xattr -w jp.mokuhanga.printer "Watanabe Keiko" $final
print "printer: $(xattr -p jp.mokuhanga.printer $final)"
# endregion: tag-print

# region: copy-attributes
# focus: cp -X
cp -- $final for-client.txt
cp -X -- $final for-archive.txt
print "cp keeps the printer:    $(xattr -p jp.mokuhanga.printer for-client.txt 2>/dev/null || print '(none)')"
print "cp -X drops the printer: $(xattr -p jp.mokuhanga.printer for-archive.txt 2>/dev/null || print '(none)')"
# endregion: copy-attributes

# region: unhide
# focus: chflags nohidden series-fuji-36/proofs
xattr -d jp.mokuhanga.printer for-client.txt
chflags nohidden series-fuji-36/proofs
print "after the call, proofs in Finder: $(flags_of series-fuji-36/proofs)"
# endregion: unhide
