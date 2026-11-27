#!/usr/bin/env zsh
# Permissions and ownership · 07 · Dakar family recipe book, a read-only file that still gets replaced
#
# Teaches:
#   - `chmod a-w` stops writes into a file: `>>` fails with "permission denied"
#   - replacing the file (write a new one, then `mv` it over) is a folder operation, so it works
#     and quietly leaves the new file's mode behind
#   - `rm` of a read-only file also only needs the folder's `w`; `rm` asks first only on a terminal
#   - `[[ -w ]]` tests before you try; protecting a file for real means `a-w` on its folder too
#   - zsh's `{ ... } always { ... }` restores the original after every attempt, even a failed one
set -o errexit -o nounset -o pipefail

if (( EUID == 0 )); then
  print -u2 "protect_recipe.zsh: run this as a regular user; root ignores read and write bits"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/recettes-ndiaye.XXXXXX")
trap 'chmod -R u+w -- "$workdir" 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir recettes archive
print -l "Thieboudienne de Mame Aminata (pour 10)" \
         "2 kg de thiof, 1 kg de riz brisé, 3 cuillères de tomate concentrée" \
         "le rof: persil, ail, piment, poivre, un cube" > archive/thieboudienne.txt

recipe=recettes/thieboudienne.txt
report() {
  local mode=$(ls -l -- $recipe 2>/dev/null | cut -c1-10)
  print "  ${1}: ${mode:-file is gone}, first line: ${$(head -n 1 -- $recipe 2>/dev/null):-(none)}"
}

# region: lock-file
# focus: chmod a-w $recipe
cp -- archive/thieboudienne.txt $recipe
chmod a-w $recipe
[[ -w $recipe ]] || print "== $recipe is read-only for everyone, Mame Aminata included"
# endregion: lock-file

# region: append-fails
# focus: >> $recipe
{
  if { print "ajouter du nététou" >> $recipe } 2>/dev/null; then
    report "cousin Ousmane appended a line"
  else
    report "cousin Ousmane's append was refused"
  fi
} always {
  rm -f -- $recipe && cp -- archive/thieboudienne.txt $recipe && chmod a-w $recipe
}
# endregion: append-fails

# region: replace-works
# focus: mv -f thieboudienne.new $recipe
{
  sed 's/(pour 10)/(pour 25, Tabaski)/' $recipe > thieboudienne.new
  mv -f thieboudienne.new $recipe
  report "nephew Cheikh replaced it with mv"
} always {
  rm -f -- $recipe && cp -- archive/thieboudienne.txt $recipe && chmod a-w $recipe
}
# endregion: replace-works

# region: delete-works
# focus: rm -- $recipe
{
  rm -- $recipe < /dev/null
  report "rm without a terminal did not ask"
} always {
  rm -f -- $recipe && cp -- archive/thieboudienne.txt $recipe && chmod a-w $recipe
}
# endregion: delete-works

# region: lock-folder
# focus: chmod a-w recettes
chmod a-w recettes
print "== recettes/ is read-only too:"
sed 's/(pour 10)/(pour 25, Tabaski)/' $recipe > thieboudienne.new
if mv -f thieboudienne.new $recipe 2>/dev/null; then report "mv still worked"; else report "mv refused"; fi
if rm -f -- $recipe 2>/dev/null; then report "rm still worked"; else report "rm refused"; fi
rm -f thieboudienne.new
# endregion: lock-folder
