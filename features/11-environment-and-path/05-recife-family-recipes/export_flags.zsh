#!/usr/bin/env zsh
# Environment and PATH · 05 · Recife family kitchen, marking the recipe year for every helper script
#
# Teaches:
#   - `typeset -x NAME=value` is the same as `export` and can combine flags
#   - `typeset -r` makes a variable readonly; a later assignment fails
#   - `typeset +x NAME` removes the export bit but keeps the shell value
#   - `typeset -p NAME` shows the flags currently attached
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cozinha-oliveira.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
print "receita de ${PRATO-} for year ${ANO_RECEITA-unknown}"' > helper.zsh
chmod +x helper.zsh

# region: typeset-x
# focus: typeset -x ANO_RECEITA=2026
typeset -x ANO_RECEITA=2026
typeset -x PRATO=bolo-de-rolo
print "== exported year: $(./helper.zsh)"
typeset -p ANO_RECEITA | sed 's/^/  /'
# endregion: typeset-x

# region: readonly
# focus: typeset -r ANO_RECEITA
typeset -r ANO_RECEITA
if ( ANO_RECEITA=2019 ) 2>/dev/null; then
  print "  readonly failed to protect"
else
  print "== readonly blocked the change; still $(printenv ANO_RECEITA)"
fi
# endregion: readonly

# region: unexport
# focus: typeset +x FORNO
# Need to clear readonly first to demonstrate +x alone; use a second var.
typeset -x FORNO=lenha
typeset +x FORNO
print "== after typeset +x FORNO:"
print "  shell FORNO=$FORNO"
if printenv FORNO >/dev/null; then print "  still in environment"; else print "  gone from environment"; fi
typeset -p FORNO | sed 's/^/  /'
# endregion: unexport
