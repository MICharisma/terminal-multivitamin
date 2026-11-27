#!/usr/bin/env zsh
# requires: macos
# Pipes and redirection · 12 · Copenhagen furniture workshop, pasting a cut list
#
# Teaches:
#   - `pbcopy` reads stdin into the macOS clipboard; `pbpaste` writes the clipboard to stdout
#   - `cmd | pbcopy` copies a command's output, ready to paste into Mail or Numbers
#   - `pbcopy < file` copies a file without opening it; `pbpaste > file` saves the clipboard
#   - `pbpaste | sort -u | pbcopy` tidies whatever is on the clipboard in place
#   - saving the clipboard first and restoring it in the `EXIT` trap leaves it as the user had it
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "cut_list.zsh uses pbcopy and pbpaste, which are macOS tools"
  exit 2
fi

# region: save-clipboard
# focus: print -rn -- "$saved_clipboard" | pbcopy
saved_clipboard=$(pbpaste 2>/dev/null || true)
workdir=$(mktemp -d "${TMPDIR:-/tmp}/snedkeri-norrebro.XXXXXX")
trap 'print -rn -- "$saved_clipboard" | pbcopy; rm -rf -- "$workdir"' EXIT
# endregion: save-clipboard
cd -- "$workdir"

print -l "top    oak        1800 x 450 x 25" \
         "side   oak         720 x 450 x 25" \
         "side   oak         720 x 450 x 25" \
         "shelf  oak        1750 x 420 x 20" \
         "back   birch-ply  1760 x 700 x 6" \
         "door   oak         700 x 430 x 20" \
         "door   oak         700 x 430 x 20" > cutlist.txt

# region: copy-output
# focus: grep ' oak ' cutlist.txt | pbcopy
grep ' oak ' cutlist.txt | pbcopy
print "on the clipboard: $(pbpaste | wc -l | tr -d ' ') oak parts for the Nørrebro café sideboard"
# endregion: copy-output

# region: paste-into-pipe
# focus: pbpaste | grep -c '^door'
print "doors to cut, counted from pbpaste: $(pbpaste | grep -c '^door')"
# endregion: paste-into-pipe

# region: copy-file
# focus: pbcopy < cutlist.txt
pbcopy < cutlist.txt
pbpaste > pasted.txt
cmp -s pasted.txt cutlist.txt && print "pbpaste gives back cutlist.txt byte for byte"
# endregion: copy-file

# region: tidy-in-place
# focus: pbpaste | sort -u | pbcopy
pbpaste | sort -u | pbcopy
print "== after pbpaste | sort -u | pbcopy, ready for the panel saw:"
pbpaste
# endregion: tidy-in-place
