#!/usr/bin/env zsh
# Quoting and parameter expansion · 08 · Dakar fishing cooperative, tallying the morning landing
#
# Teaches:
#   - `typeset -A catch` declares an associative array (a table keyed by name)
#   - `(( catch[$species] += kg ))` adds to a key, starting from nothing
#   - `${(k)catch}` lists keys, `${(v)catch}` values, `${(kv)catch}` pairs; `(o)` sorts them
#   - `${+catch[barracuda]}` is 1 if the key exists, 0 if not, without tripping `nounset`
#   - `${(k)catch[(r)180]}` looks up a key by its value
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/soumbedioune-landing.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# Each pirogue reports as it reaches the beach: boat, species, kilograms.
landings=( "ndeye-fatou yaboy 420" "baye-fall thiof 38" "keur-massar yaboy 310"
           "ndeye-fatou capitaine 54" "baye-fall yaboy 180" "keur-massar thiof 21" )

# region: declare
# focus: typeset -A catch boats
typeset -A catch boats
# endregion: declare

# region: accumulate
# focus: (( catch[$species] += kg ))
for landing in $landings; do
  read -r boat species kg <<< "$landing"
  (( catch[$species] += kg ))
  boats[$species]+="$boat "
done
print "species landed: ${#catch}"
# endregion: accumulate

# region: keys-values
# focus: for species kg in ${(kv)catch}
print "== by species (keys sorted with (ok)):"
for species in ${(ok)catch}; print "  ${(r:10:)species} ${(l:4:)catch[$species]} kg  from ${(j:, :)${(u)=boats[$species]}}"
total=0
for species kg in ${(kv)catch}; (( total += kg ))
print "total on the beach: $total kg (values, smallest first: ${(@on)${(@v)catch}})"
# endregion: keys-values

# region: exists
# focus: ${+catch[barracuda]}
print "thiof landed? ${+catch[thiof]}; barracuda landed? ${+catch[barracuda]}"
# endregion: exists

# region: reverse-lookup
# focus: ${(k)catch[(r)$heaviest]}
heaviest=${${(On)${(v)catch}}[1]}
print "heaviest species: ${(k)catch[(r)$heaviest]} with $heaviest kg, priced for the Kermel market first"
# endregion: reverse-lookup
