#!/usr/bin/env zsh
# Quoting and parameter expansion · 01 · Hong Kong dim sum teahouse, printing the menu board
#
# Teaches:
#   - single quotes keep every character literal, `$` included: `'HK$38'`
#   - double quotes expand `$`, so `"HK$38"` prints `HK`: zsh reads `$38` as the (empty) 38th
#     argument; bash and sh read `$3` then `8`
#   - inside double quotes `\$` is a literal dollar sign, and `"$price"` stays one word
#   - quoted pieces written side by side join into one word: `'HK$'"$price"`
#   - no quote can be escaped inside single quotes: close, add `\'`, reopen (`'Lin'\''s'`), or use double quotes
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/teahouse-sheung-wan.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: single-quotes
# focus: HK$38
print 'Har gow, 4 pieces: HK$38' > board.txt
print "single quotes: $(< board.txt)"
# endregion: single-quotes

# region: double-quote-trap
# focus: "$1, $2 pieces: HK$38"
buggy_line() {
  setopt local_options unset
  print "$1, $2 pieces: HK$38"
}
print "double quotes: $(buggy_line 'Siu mai' 4)"
# endregion: double-quote-trap

# region: escaped-dollar
# focus: HK\$$price
typeset -A prices=( 'Char siu bao' 32 'Cheung fun' 36 'Egg tart' 28 )
for dish in ${(ok)prices}; do
  price=$prices[$dish]
  print "$dish: HK\$$price" >> board.txt
done
print -r -- '== with \$ inside double quotes:'
tail -n 3 board.txt
# endregion: escaped-dollar

# region: joined-pieces
# focus: total HK$'"$set_price"
set_price=168
print 'Set for two: '"$((set_price / 2))"' each, total HK$'"$set_price" >> board.txt
tail -n 1 board.txt
# endregion: joined-pieces

# region: apostrophes
# focus: Lin Heung'\''s
print 'Lin Heung'\''s lotus seed bun: sold out' >> board.txt
print "Auntie Mei's turnip cake: back at 11:00" >> board.txt
print "== the board, $(( $(wc -l < board.txt) )) lines:"
cat board.txt
# endregion: apostrophes
