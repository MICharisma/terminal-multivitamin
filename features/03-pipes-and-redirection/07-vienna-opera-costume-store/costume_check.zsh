#!/usr/bin/env zsh
# Pipes and redirection · 07 · Vienna opera costume store, checking the crates after a tour
#
# Teaches:
#   - `<(command)` runs a command and hands its output to another command as a file name
#   - `diff <(sort a) <(sort b)` and `comm -23 <(sort a) <(sort b)` compare unsorted lists with no temp files
#   - `paste <(cut ...) <(cut ...)` lines up two derived columns side by side
#   - `<(...)` is a pipe, readable once; zsh's `=(...)` writes a real temp file for tools
#     that seek or read twice, and removes it when the command ends
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/kostuemfundus.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/*.txt $workdir/
cd -- "$workdir"

# region: diff-unsorted
# focus: diff <(sort packed-for-tour.txt) <(sort unpacked-in-vienna.txt)
print "== diff of the sorted lists (< packed only, > unpacked only):"
diff <(sort packed-for-tour.txt) <(sort unpacked-in-vienna.txt) | grep '^[<>]' || true
# endregion: diff-unsorted

# region: comm-missing
# focus: comm -23 <(sort packed-for-tour.txt) <(sort unpacked-in-vienna.txt)
missing=( ${(f)"$(comm -23 <(sort packed-for-tour.txt) <(sort unpacked-in-vienna.txt))"} )
print "still missing after the Tokyo tour: ${#missing}"
print -l "  "$^missing
# endregion: comm-missing

# region: comm-extra
# focus: comm -13
print "== in our crates but not on our list:"
comm -13 <(sort packed-for-tour.txt) <(sort unpacked-in-vienna.txt) | sed 's/^/  /'
# endregion: comm-extra

# region: paste-columns
# focus: paste -d' ' <(cut -c1-3 packed-for-tour.txt | sort | uniq -c) <(cut -c1-3 unpacked-in-vienna.txt | sort | uniq -c)
print "== costumes per production, packed vs unpacked:"
paste -d' ' <(cut -c1-3 packed-for-tour.txt | sort | uniq -c) <(cut -c1-3 unpacked-in-vienna.txt | sort | uniq -c) |
  while read -r packed production unpacked _; do
    print "  $production: packed $packed, unpacked $unpacked"
  done
# endregion: paste-columns

# region: temp-file-form
# focus: =(sort unpacked-in-vienna.txt)
test -f <(sort unpacked-in-vienna.txt) && kind=file || kind="pipe, read once"
print "<(...) gives a $kind"
test -f =(sort unpacked-in-vienna.txt) && kind="regular file" || kind=pipe
print "=(...) gives a $kind, deleted when the command ends"
# endregion: temp-file-form
