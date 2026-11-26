#!/usr/bin/env zsh
# Sorting, counting, and columns · 10 · Porto wine lodge, measuring the tasting notes sheet
#
# Teaches:
#   - `wc -l`, `wc -w`, and `wc -c` count lines, words, and bytes in one pass
#   - `wc -L` reports the longest line length (GNU and BSD, with different padding on counts)
#   - reading `wc -l` through arithmetic `$(($(wc -l < f)))` drops BSD's leading spaces
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/gaia-lodge.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- ${0:A:h}/fixtures/tasting-notes.txt $workdir/
cd -- "$workdir"

count_lines() {
  local file=$1
  print $(( $(wc -l < "$file") ))
}

count_words() {
  local file=$1
  print $(( $(wc -w < "$file") ))
}

count_chars() {
  local file=$1
  print $(( $(wc -c < "$file") ))
}

# region: wc-text
# focus: count_lines tasting-notes.txt
line_total=$(count_lines tasting-notes.txt)
word_total=$(count_words tasting-notes.txt)
byte_total=$(count_chars tasting-notes.txt)
print "== lodge totals: $line_total lines, $word_total words, $byte_total bytes"
# endregion: wc-text

# region: wc-longest
# focus: wc -L
longest=$(wc -L < tasting-notes.txt | tr -d ' ')
print "longest tasting note: $longest characters"
print "== longest line for the back label:"
while IFS= read -r line; do
  if (( ${#line} == longest )); then
    print "$line"
    break
  fi
done < tasting-notes.txt
# endregion: wc-longest

# region: wc-arithmetic
# focus: arithmetic count: $arith_wc
raw_wc=$(wc -l tasting-notes.txt)
arith_wc=$(count_lines tasting-notes.txt)
print "raw wc -l field: [${${(f)raw_wc}[1]}], arithmetic count: $arith_wc"
# endregion: wc-arithmetic