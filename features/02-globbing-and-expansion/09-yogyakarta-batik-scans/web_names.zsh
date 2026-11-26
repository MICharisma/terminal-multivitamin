#!/usr/bin/env zsh
# Globbing and expansion · 09 · Yogyakarta batik studio, naming web images from scans
#
# Teaches:
#   - modifiers :t (tail), :h (head), :r (root, no extension), :e (extension)
#   - a modifier inside a glob qualifier, *.tif(:r), changes every match
#   - modifiers on an unquoted array apply to each element; (u) drops duplicates
#   - :s/old/new/ substitutes inside each name
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/batik-sekar-jagad.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

for scan in parang/parang-rusak_scan-600dpi.tif parang/parang-barong_scan-600dpi.tif \
            kawung/kawung-picis_scan-600dpi.tif truntum/truntum-sogan_scan-600dpi.tif \
            truntum/truntum-garuda_scan-1200dpi.tiff; do
  mkdir -p ${scan:h}
  : > $scan
done

# region: pull-apart
# focus: ${scan:e}
scan=truntum/truntum-garuda_scan-1200dpi.tiff
print "head ${scan:h} | tail ${scan:t} | root ${scan:r} | extension ${scan:e}"
# endregion: pull-apart

# region: qualifier-modifier
# focus: */*.tif(:t:r)
print "== motifs scanned at 600 dpi:"
print -l */*.tif(:t:r)
# endregion: qualifier-modifier

# region: array-modifiers
# focus: ${(u)scans:h}
scans=( */*.(tif|tiff) )
families=( ${(u)scans:h} )
print "== motif families: $families"
# endregion: array-modifiers

# region: substitute-names
# focus: ${${scan:t:r}:s/_scan-600dpi//:s/_scan-1200dpi//}
print "== web export plan:"
for scan in $scans; do
  web=${${scan:t:r}:s/_scan-600dpi//:s/_scan-1200dpi//}
  print "$scan -> web/${scan:h}/$web.jpg"
done > export-plan.txt
cat export-plan.txt
# endregion: substitute-names
