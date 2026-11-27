#!/usr/bin/env zsh
# Navigation and files · 01 · Lisbon pastelaria Christmas orders
#
# Teaches:
#   - `mkdir -p` builds a nested folder tree in one call and is safe to rerun
#   - `cd` with relative paths (`a/b/c`, `..`) and reading where you are from `$PWD`
#   - `touch` creates empty order slips; `ls -F` marks folders with a trailing `/`
#   - plain `mkdir` refuses a folder that already exists
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pastelaria-belem.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: build-tree
# focus: mkdir -p
mkdir -p encomendas/natal/bolo-rei encomendas/natal/pasteis-de-nata encomendas/consoada
# endregion: build-tree

# region: enter-counter
# focus: cd encomendas/natal/bolo-rei
cd encomendas/natal/bolo-rei
print "at the counter: ${PWD#$workdir/}"
touch familia-mendes.txt cafe-alcantara.txt
cd ../pasteis-de-nata
print "at the counter: ${PWD#$workdir/}"
touch hotel-jeronimos.txt escola-restelo.txt
# endregion: enter-counter

# region: list-orders
# focus: ls -F
cd -- "$workdir/encomendas"
print "== encomendas:"
ls -F
print "== natal/bolo-rei:"
ls -1 natal/bolo-rei
# endregion: list-orders

# region: rerun-safely
# focus: mkdir -p natal/bolo-rei
mkdir -p natal/bolo-rei && print "mkdir -p on an existing folder: fine"
if ! mkdir consoada 2>/dev/null; then
  print "plain mkdir on an existing folder: refused"
fi
# endregion: rerun-safely
