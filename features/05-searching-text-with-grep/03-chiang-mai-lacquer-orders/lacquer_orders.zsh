#!/usr/bin/env zsh
# Searching text with grep · 03 · Chiang Mai lacquer atelier, filtering this week's orders
#
# Teaches:
#   - `grep -E` (or `egrep`) turns on extended regular expressions: `|`, `+`, `?`, `()`
#   - `bowl|tray` matches either word; `(gold|silver)-leaf` groups an alternative
#   - `x{2,}` needs `-E` (or `\{2,\}` in basic regex); basic `grep` treats `{}` literally on some systems
#   - prefer `grep -E` over the `egrep` spelling; both exist, `-E` is the portable long form
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ban-tawai-lacquer.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -l \
  "ord-401 bowl black gold-leaf 12cm for Gallery Siam" \
  "ord-402 tray red mother-of-pearl 30cm for Hotel Rachamankha" \
  "ord-403 bowl black silver-leaf 16cm for private client Mae Rim" \
  "ord-404 vase gold-leaf 25cm for Embassy reception" \
  "ord-405 tray black gold-leaf 40cm for Cafe de Chiang Mai" \
  "ord-406 bowl red plain 12cm for market stall" \
  "ord-407 box gold-leaf 8cm for wedding favour set" > orders.txt

# region: alternation
# focus: grep -E 'bowl|tray' orders.txt
print "== bowls and trays only:"
grep -E 'bowl|tray' orders.txt
# endregion: alternation

# region: group
# focus: grep -E '(gold|silver)-leaf' orders.txt
print "== leaf finishes:"
grep -E '(gold|silver)-leaf' orders.txt
# endregion: group

# region: quantifier
# focus: grep -E '[0-9]{2,}cm' orders.txt
print "== pieces 10cm or larger (two or more digits):"
grep -E '[0-9]{2,}cm' orders.txt
# endregion: quantifier

# region: combined
# focus: grep -E '^(ord-[0-9]+) (bowl|tray) .*gold-leaf'
print "== gold-leaf bowls and trays for the Bangkok shipment:"
grep -E '^(ord-[0-9]+) (bowl|tray) .*gold-leaf' orders.txt
# endregion: combined
