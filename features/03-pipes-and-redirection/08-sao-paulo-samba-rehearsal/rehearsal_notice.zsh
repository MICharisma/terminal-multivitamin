#!/usr/bin/env zsh
# Pipes and redirection · 08 · São Paulo samba school, one rehearsal notice for every wing
#
# Teaches:
#   - zsh's `multios`: `print notice > a > b > c` writes the same output to all three files
#   - `>> a >> b` appends to several files; `> file | cmd` writes to the file and the pipe at once
#   - `cat < a < b` reads several inputs one after another, like `cat a b`
#   - `setopt no_multios` restores the sh/bash rule: only the last redirection counts
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/escola-bixiga.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir alas

# region: write-to-many
# focus: > alas/bateria.txt > alas/baianas.txt > alas/passistas.txt
print "Ensaio técnico: Saturday 20:00, Sambódromo do Anhembi, gate 3" \
  > alas/bateria.txt > alas/baianas.txt > alas/passistas.txt
for wing in alas/*.txt; print "${wing:t:r}: $(< $wing)"
# endregion: write-to-many

# region: append-to-many
# focus: >> alas/bateria.txt >> alas/passistas.txt
print "Bring white shoes; the samba-enredo is the new 2027 version" >> alas/bateria.txt >> alas/passistas.txt
print "Baianas: skirts fitted at the barracão on Friday" >> alas/baianas.txt
for wing in alas/*.txt; print "${wing:t:r} notice has $(( $(wc -l < $wing) )) lines"
# endregion: append-to-many

# region: file-and-pipe
# focus: > alas/diretoria.txt | wc -l
print -l "Mestre de bateria: Thiago Moreira" "Carnavalesca: Renata Albuquerque" \
         "Puxador: Edson Batista" > alas/diretoria.txt | wc -l | read -r directors
print "directors counted through the pipe: $directors; written to the file: $(( $(wc -l < alas/diretoria.txt) ))"
# endregion: file-and-pipe

# region: read-from-many
# focus: cat < alas/diretoria.txt < alas/bateria.txt
print "== WhatsApp message for the bateria (directors first, then their notice):"
cat < alas/diretoria.txt < alas/bateria.txt | sed 's/^/  /'
# endregion: read-from-many

# region: no-multios
# focus: setopt no_multios
(
  setopt no_multios
  print "Rehearsal moved to 21:00" > alas/bateria.txt > alas/baianas.txt
  print "with no_multios, bateria.txt has $(( $(wc -l < alas/bateria.txt) )) lines (opened and emptied), baianas.txt has $(( $(wc -l < alas/baianas.txt) ))"
)
# endregion: no-multios
