#!/usr/bin/env zsh
# Navigation and files · 11 · Marrakech carpet cooperative named folders
#
# Teaches:
#   - `hash -d` gives a deep folder a short name you can `cd` to as `~name`
#   - `print -D` (and the `${(D)...}` flag) rewrite a path using those names
#   - the longest matching name wins, so `~orders` beats `~coop` inside orders
#   - `~name` works anywhere a path does: `ls`, `cp`, and in the middle of a longer path
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cooperative-tazra.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p cooperative/commandes/2026/export/berlin cooperative/commandes/2026/export/kyoto \
         cooperative/teintures/henna cooperative/tisserandes
print "beni ouarain 2x3 m, natural wool, ship via Casablanca" > cooperative/commandes/2026/export/berlin/galerie-moser.txt
print "boucherouite runner, saffron and indigo"               > cooperative/commandes/2026/export/kyoto/ryokan-hanami.txt
print "henna bath: 3 kg leaves, steep overnight"              > cooperative/teintures/henna/recette.txt

# region: name-folders
# focus: hash -d coop=$workdir/cooperative
hash -d coop=$workdir/cooperative
hash -d orders=$workdir/cooperative/commandes/2026
# endregion: name-folders

# region: jump-by-name
# focus: cd ~orders/export/berlin
cd ~orders/export/berlin
print "now in $(print -D $PWD)"
print "  $(< galerie-moser.txt)"
cd ~coop/teintures/henna
print "now in $(print -D $PWD)"
# endregion: jump-by-name

# region: abbreviate-paths
# focus: ${(D)shipment}
for shipment in ~orders/export/*/*.txt; do
  print "shipment note: ${(D)shipment}"
done
print "dye recipe:    ${(D):-$workdir/cooperative/teintures/henna/recette.txt}"
# endregion: abbreviate-paths

# region: names-in-commands
# focus: cp -- ~coop/teintures/henna/recette.txt ~orders/export/kyoto/
cp -- ~coop/teintures/henna/recette.txt ~orders/export/kyoto/
print "== ls ~orders/export/kyoto:"
ls -1 ~orders/export/kyoto
# endregion: names-in-commands
