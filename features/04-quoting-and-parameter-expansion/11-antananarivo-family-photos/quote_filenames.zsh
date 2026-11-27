#!/usr/bin/env zsh
# Quoting and parameter expansion · 11 · Antananarivo family photo archive, quoting the filenames
#
# Teaches:
#   - `${(q)name}` quotes a value the way zsh would type it back in: spaces, quotes, and `$` become safe
#   - `${(qq)name}` always wraps in single quotes; `${(qqq)name}` always wraps in double quotes
#   - `${name// /_}` replaces every space; `${(Q)quoted}` undoes one layer of quoting, so a plan file of quoted names becomes real names again
#   - `"${(@q)photos}"` quotes each array element, ready to paste into a script or a `print -l`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/album-famille-tana.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir originals
photos=(
  "Nouvel An 2026 - famille Razafy.jpg"
  "Tante Voahangy's jardin (Antananarivo).jpg"
  'Lac$Anosy, pique-nique.jpg'
  "Fianarantsoa - 'Maison de la Reine'.jpg"
)
for photo in $photos; print "JPEG placeholder for $photo" > originals/$photo

# region: quote-one
# focus: ${(q)photo}
print "== how zsh would type each name:"
for photo in $photos; print -r -- "  ${(q)photo}"
# endregion: quote-one

# region: always-single
# focus: ${(qq)photos[3]}
print -r -- "always single quotes: ${(qq)photos[3]}"
print -r -- "always double quotes: ${(qqq)photos[3]}"
# endregion: always-single

# region: write-plan
# focus: "${(@q)photos}"
print -r -l -- "${(@q)photos}" > rename.plan
print "rename.plan holds ${#${(f)"$(<rename.plan)"}} quoted lines:"
sed 's/^/  /' rename.plan
# endregion: write-plan

# region: unquote
# focus: ${name// /_}
mkdir renamed
while IFS= read -r line; do
  name=${(Q)line}
  cp -- "originals/$name" "renamed/${name// /_}"
done < rename.plan
print "== after (Q) and space replacement, files under renamed/:"
print -l renamed/*(:t) | sed 's/^/  /'
# endregion: unquote
