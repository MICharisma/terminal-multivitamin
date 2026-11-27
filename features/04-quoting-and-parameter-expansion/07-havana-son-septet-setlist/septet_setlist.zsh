#!/usr/bin/env zsh
# Quoting and parameter expansion · 07 · Havana son septet, who plays tonight
#
# Teaches:
#   - zsh arrays start at 1: `$band[1]` is the first element, `$band[-1]` the last, `$band[2,4]` a slice
#   - `${#band}` counts elements; `band+=( ... )` appends; `band[2]=()` removes an element
#   - `${band[(i)pattern]}` finds the index of the first match; `${band[(r)pattern]}` the value
#   - `${band:|absent}` keeps elements not in `absent`; `${tonight:*regulars}` keeps those in both
#   - `"${band[@]}"` passes one word per element; `"$band"` (or `"${band[*]}"`) passes one joined word
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/septeto-centro-habana.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

count_words() { print "$# word(s)" }

# region: index-and-slice
# focus: $band[2,4]
band=( "Yoel:tres" "Mariela:voz" "Ernesto:trompeta" "Lázaro:bongó" "Odalys:maracas" "Raúl:contrabajo" "Iván:guitarra" )
print "septeto: ${#band} players; first $band[1], last $band[-1]"
print "the front line (2 to 4): $band[2,4]"
# endregion: index-and-slice

# region: append-remove
# focus: band+=( "Dayron:timbales" )
band+=( "Dayron:timbales" )
band[(i)Iván:*]=()
print "with a guest on timbales and Iván off sick: ${#band} players, last now $band[-1]"
# endregion: append-remove

# region: search
# focus: ${band[(i)*:trompeta]}
print "trumpet is player ${band[(i)*:trompeta]}: ${${band[(r)*:trompeta]}%%:*}"
print "a flute? index ${band[(i)*:flauta]} means not found (one past the end)"
# endregion: search

# region: set-operations
# focus: ${band:|absent}
regulars=( "Yoel:tres" "Mariela:voz" "Ernesto:trompeta" "Lázaro:bongó" "Odalys:maracas" "Raúl:contrabajo" "Iván:guitarra" )
absent=( "Raúl:contrabajo" )
tonight=( ${band:|absent} )
print "on stage at the Casa de la Música: ${#tonight}"
playing=( ${tonight:*regulars} ) guests=( ${tonight:|regulars} )
print "regulars playing: ${#playing}, guests: ${(j:, :)guests%%:*}"
# endregion: set-operations

# region: one-or-many-words
# focus: count_words "${tonight[@]}"
print "\"\${tonight[@]}\" passes $(count_words "${tonight[@]}"), \"\$tonight\" passes $(count_words "$tonight")"
setlist=( "Chan Chan" "El Cuarto de Tula" "Lágrimas Negras" )
for song in "${setlist[@]}"; print "  ${setlist[(i)$song]}. $song"
# endregion: one-or-many-words
