#!/usr/bin/env zsh
# Permissions and ownership · 06 · Quito university, an exam drop folder students cannot browse
#
# Teaches:
#   - on a folder, `r` lists names, `x` lets you through to the files inside, `w` creates and deletes
#   - `w` is useless without `x`: creating or deleting a name needs both
#   - `-wx` (mode 300) is a drop box: hand in a file, open it again by name, but never list the others
#   - `r` without `x` lists names, yet every file stays out of reach
#   - root ignores these bits, so the script refuses to run as root
set -o errexit -o nounset -o pipefail

if (( EUID == 0 )); then
  print -u2 "folder_matrix.zsh: run this as a regular user; root ignores read and write bits"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/examen-fisica.XXXXXX")
trap 'chmod -R u+rwx -- "$workdir" 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: operations
# focus: can_create() { : > $1/entrega-quishpe.pdf }
can_list()   { local names=( $1/*(N) ); (( $#names )) }
can_enter()  { ( cd -- $1 ) }
can_read()   { [[ -n "$(< $1/enunciado.txt)" ]] }
can_create() { : > $1/entrega-quishpe.pdf }
can_delete() { rm -- $1/borrador.txt && : > $1/borrador.txt }
# endregion: operations

# region: matrix
# focus: can_$op $folder 2>/dev/null
printf '%-6s %-10s' mode ""; printf ' %7s' list enter read create delete; print
for mode in 700 500 300 100 600 400; do
  folder=entregas-$mode
  mkdir $folder
  print "Física II, examen parcial: 3 problemas, 90 minutos" > $folder/enunciado.txt
  print "draft" > $folder/borrador.txt
  chmod $mode $folder
  printf '%-6s %-10s' $mode $(ls -ld -- $folder | cut -c1-10)
  for op in list enter read create delete; do
    if can_$op $folder 2>/dev/null; then printf ' %7s' yes; else printf ' %7s' no; fi
  done
  print
done
# endregion: matrix

# region: drop-box
# focus: chmod 300 buzon
mkdir buzon
chmod 300 buzon
print "Andrea Quishpe, problema 1: v = 12.4 m/s" > buzon/quishpe-andrea.pdf
print "Mateo Chicaiza, problema 1: v = 12.6 m/s" > buzon/chicaiza-mateo.pdf
print "== the drop box (300): hand in, then reopen your own by name"
print "  Andrea rereads hers: $(< buzon/quishpe-andrea.pdf)"
names=( buzon/*(N) )
print "  listing the box shows $#names names"
# endregion: drop-box
