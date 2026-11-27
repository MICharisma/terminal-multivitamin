#!/usr/bin/env zsh
# Quoting and parameter expansion · 05 · Athens family wedding, place cards from the aunts' guest list
#
# Teaches:
#   - zsh case flags: `${(C)name}` capitalizes each word, `${(U)name}` and `${(L)name}` change the whole string
#   - `(C)` starts a new word after any non-letter, so `anna-maria` becomes `Anna-Maria`, and `mcgrath` becomes `Mcgrath`
#   - flags apply to every element of an array; inside double quotes a nested array needs `@`
#     to stay an array, so `"${(j:, :)${(@C)guests}}"` joins names, not one long string
#   - `${(r:28::.:)name}` pads on the right with dots to a fixed width; `(l:...)` pads on the left
#   - bash 4 spells these `${name^^}` and `${name,,}`; macOS's bash 3.2 has neither
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/gamos-kifisia.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# Typed by three aunts, on three phones.
guests=( "giorgos PAPADOPOULOS" "ELENI kostaki" "anna-maria vlachou" "dimitris o'neill-karras"
         "sophia mcgrath" "yiayia katerina" )
typeset -A table_of=( "giorgos PAPADOPOULOS" 1 "ELENI kostaki" 1 "anna-maria vlachou" 4
                      "dimitris o'neill-karras" 4 "sophia mcgrath" 7 "yiayia katerina" 1 )

# region: capitalize
# focus: ${(C)guest}
print "== as typed, then with (C):"
for guest in $guests; print "  ${(r:26:)guest}-> ${(C)guest}"
# endregion: capitalize

# region: upper-lower
# focus: ${(U)${guest##* }}
print "== seating chart by surname, emails by first name:"
for guest in $guests; do
  print "  ${(r:18:)${(U)${guest##* }}} ${(L)${guest%% *}}@gamos-maria-nikos.gr"
done
# endregion: upper-lower

# region: whole-array
# focus: ${(j:, :)${(@C)guests}}
print "without @: ${(j:, :)${(C)guests[1,2]}}"
print "with @:    ${(j:, :)${(@C)guests[1,2]}}"
print "== the whole list for the priest: ${(j:, :)${(@C)guests}}"
# endregion: whole-array

# region: dot-leaders
# focus: ${(r:28::.:)${(C)guest}}
print "== place cards for the printer in Kifisia:"
for guest in ${(oi)guests}; do
  print "  ${(r:28::.:)${(C)guest}} table ${(l:2:)table_of[$guest]}"
done
# endregion: dot-leaders
