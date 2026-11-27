#!/usr/bin/env zsh
# requires: macos
# Permissions and ownership · 13 · Barcelona architecture studio, guarding competition renders with ACLs
#
# Teaches:
#   - `chmod +a "everyone deny delete"` adds an access control entry (ACE) that stops even the owner
#   - `ls -le` lists the ACEs under the file; plain `ls -l` only shows a `+` after the mode
#   - `file_inherit,directory_inherit` on a folder copies an ACE onto every new file, marked `inherited`
#   - `chmod -a` removes one entry, `chmod -N` removes them all
#   - deny-delete entries also stop `rm -rf`, so the cleanup trap runs `chmod -R -N` first
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "acl_renders.zsh uses chmod +a and ls -e, which are macOS features"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/estudi-sagrera.XXXXXX")
trap 'chmod -R -N "$workdir" 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p concurs-sagrera/renders
print "Parc del Camí Comtal, vista aèria, v7" > concurs-sagrera/renders/vista-aeria_v7.png
print "Plaça de l'estació, capvespre, v4"    > concurs-sagrera/renders/placa-capvespre_v4.png

aces() { ls -led -- $1 | tail -n +2 | sed 's/^ */    /' }
mode_column() { ls -ld -- $1 | cut -c1-11 | tr -d ' ' }

# region: deny-delete
# focus: chmod +a "everyone deny delete" $render
render=concurs-sagrera/renders/vista-aeria_v7.png
chmod +a "everyone deny delete" $render
print "== ls -l only shows a + : $(mode_column $render)"
print "== ls -le shows the entry:"
aces $render
# endregion: deny-delete

# region: owner-blocked
# focus: rm -f -- $render
if rm -f -- $render 2>/dev/null; then
  print "rm by the owner: removed"
else
  print "rm by the owner: refused, the deny entry wins"
fi
# endregion: owner-blocked

# region: inherit
# focus: file_inherit,directory_inherit
chmod +a "everyone deny delete,file_inherit,directory_inherit" concurs-sagrera/renders
print "Estació de la Sagrera, interior, v2" > concurs-sagrera/renders/interior-estacio_v2.png
print "== a render saved after the folder entry inherits it:"
aces concurs-sagrera/renders/interior-estacio_v2.png
# endregion: inherit

# region: remove-one
# focus: chmod -a "everyone deny delete" $render
chmod -a "everyone deny delete" $render
print "== after chmod -a on vista-aeria_v7.png: $(mode_column $render)"
rm -f -- $render && print "rm by the owner: removed, the competition picked v8"
# endregion: remove-one

# region: remove-all
# focus: chmod -R -N concurs-sagrera
chmod -R -N concurs-sagrera
print "== after chmod -R -N, no ACEs are left:"
for entry in concurs-sagrera/renders concurs-sagrera/renders/*; do
  print "  $(mode_column $entry) ${entry#concurs-sagrera/}"
done
# endregion: remove-all
