#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 10 · La Paz family recipe cards to HTML
#
# Teaches:
#   - a here-document feeds recipe text without a temporary .txt file
#   - `textutil -stdin -format txt -convert html` converts that stream to HTML
#   - the HTML card lands beside the script's other kitchen files
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "recipe_card.zsh uses textutil, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/mamani-saltenas.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: heredoc-recipe
# focus: <<'RECIPE'
recipe_text=$(cat <<'RECIPE'
Salteñas de la abuela Rosa
Masa: harina, manteca, ají amarillo.
Relleno: carne de res, papa, arveja, caldo gelatinado.
Hornear hasta que el jugo no se escape.
RECIPE
)
# endregion: heredoc-recipe

# region: stdin-convert
# focus: textutil -stdin
print -r -- "$recipe_text" | textutil -stdin -format txt -convert html -output saltena-card.html
print "card: saltena-card.html"
        if grep -q 'abuela Rosa' saltena-card.html; then
          print "html contains the title: yes"
        else
          print "html contains the title: no"
        fi
# endregion: stdin-convert
