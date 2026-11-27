#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 06 · Almaty climbing club route cards
#
# Teaches:
#   - `case ${card:e} in` routes each card by extension
#   - `open -a Preview` targets a specific app instead of the default
#   - `open file://...` opens a local HTML topo in the default browser
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "open_routes.zsh uses open, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/almaty-alpine.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p routes
print "%PDF-1.4 club route Tuyuk Su" > routes/tuyuk-su.pdf
print '<html><body><h1>Kok-Jailau topo</h1></body></html>' > routes/kok-jailau.html
print "lat,lon track for Big Almaty Peak" > routes/big-almaty.gpx

headless=0
[[ $TERM == dumb || ! -t 1 ]] && headless=1

for card in routes/tuyuk-su.pdf routes/kok-jailau.html routes/big-almaty.gpx; do
  # region: route-case
  # focus: case ${card:e} in
  case ${card:e} in
    # endregion: route-case
    (pdf)
      # region: open-preview
      # focus: open -a Preview
      if (( headless )); then
        print "would: open -a Preview -- $card"
      else
        open -a Preview -- $card
      fi
      print "pdf -> Preview: ${card:t}"
      # endregion: open-preview
      ;;
    (html)
      # region: open-file-url
      # focus: open file://
      if (( headless )); then
        print "would: open file://\$workdir/$card"
      else
        open "file://$workdir/$card"
      fi
      print "html -> file url: ${card:t}"
      # endregion: open-file-url
      ;;
    (*)
      print "skip unsupported: ${card:t}"
      ;;
  esac
done
