#!/usr/bin/env zsh
# Finding files with find and xargs · 03 · Dublin traditional music school, who is ready for the grade exam
#
# Teaches:
#   - `xargs` splits its input on blanks and newlines, so `ciaran byrne/the silver spear.txt`
#     arrives as four arguments
#   - `xargs` also reads quotes as quoting, so the apostrophe in `sean o'neill` stops it with an error
#   - `find -print0 | xargs -0` separates names with NUL bytes, the one byte a file name cannot hold
#   - `find -exec grep -l ... {} +` batches names the way `xargs` does, with no parsing at all
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/scoil-cheoil.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -A notes=(
  "aoife ni bhriain/drowsy maggie.txt"  "fiddle, reel: ready for grade exam"
  "sean o'neill/the kesh jig.txt"       "tin whistle, jig: ready for grade exam"
  "ciaran byrne/the silver spear.txt"   "flute, reel: needs work on the rolls"
  "niamh-doyle/star-of-munster.txt"     "concertina, reel: ready for grade exam"
)
for note text in "${(@kv)notes}"; do
  mkdir -p "recordings/${note:h}"
  print -r -- "$text" > "recordings/$note"
done

# region: split-on-blanks
# focus: xargs printf '  [%s]\n'
print "== what xargs makes of one path with spaces:"
print -r -- "recordings/ciaran byrne/the silver spear.txt" | xargs printf '  [%s]\n'
# endregion: split-on-blanks

# region: apostrophe-stops-xargs
# focus: find recordings -name '*.txt' | xargs grep -l 'ready for grade exam'
if ! find recordings -name '*.txt' | xargs grep -l 'ready for grade exam' >/dev/null 2>&1; then
  print "plain xargs gave up: the apostrophe in \"sean o'neill\" opened a quote it never closed"
fi
# endregion: apostrophe-stops-xargs

# region: null-separated
# focus: -print0 | xargs -0
print "== ready for the exam, names passed with -print0 | xargs -0:"
find recordings -name '*.txt' -print0 | xargs -0 grep -l 'ready for grade exam' | sort
# endregion: null-separated

# region: exec-plus
# focus: -exec grep -l 'ready for grade exam' {} +
print "== the same list from -exec ... {} +, no xargs at all:"
find recordings -name '*.txt' -exec grep -l 'ready for grade exam' {} + | sort
# endregion: exec-plus
