#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 09 · Sapporo miso brewery label formats
#
# Teaches:
#   - `sips -g format` reads the image format keyword
#   - `sips -s format jpeg` writes a JPEG proof beside the PNG master
#   - a before/after pair makes the conversion obvious in the ledger
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "label_formats.zsh uses sips, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sapporo-miso.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/aka-miso-label.png aka-miso-label.png

# region: before-format
# focus: sips -g format
before=$(sips -g format -- aka-miso-label.png | awk '/format:/{print tolower($2)}')
print "before: aka-miso-label.png format=$before"
# endregion: before-format

# region: convert-jpeg
# focus: sips -s format jpeg
sips -s format jpeg --out aka-miso-label.jpg -- aka-miso-label.png >/dev/null
after=$(sips -g format -- aka-miso-label.jpg | awk '/format:/{print tolower($2)}')
print "after:  aka-miso-label.jpg format=$after"
# endregion: convert-jpeg

print "proof ready for the Otaru printer"
