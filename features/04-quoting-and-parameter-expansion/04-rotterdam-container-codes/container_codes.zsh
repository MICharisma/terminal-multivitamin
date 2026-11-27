#!/usr/bin/env zsh
# Quoting and parameter expansion · 04 · Rotterdam container terminal, decoding manifest file names
#
# Teaches:
#   - `${path##*/}` strips the longest match from the front (the folders); `${path%/*}` strips from the end
#   - one `#` or `%` removes the shortest match, two remove the longest: `${name%%_*}` vs `${name%_*}`
#   - `${id:0:4}` and `${id:4:6}` slice by position; `${id: -1}` counts from the end (note the space)
#   - `${size/45G1/40ft high cube}` replaces the first match; `${path//\//:}` replaces every one
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/maasvlakte-gate.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

manifests=(
  arrivals/2026-11-26/msc-aurora/MSCU7065291_45G1_vgm-weighed.json
  arrivals/2026-11-26/msc-aurora/TGHU4471029_22G1_customs-hold.json
  arrivals/2026-11-26/ever-gentle/EGHU9310442_45R1_reefer-check.json
)

# region: strip-folders
# focus: ${manifest##*/}
manifest=$manifests[1]
print "file:   ${manifest##*/}"
print "folder: ${manifest%/*}"
print "vessel: ${${manifest%/*}##*/}"
# endregion: strip-folders

# region: shortest-longest
# focus: ${name%%_*}
name=${${manifest##*/}%.json}
print "${name%%_*}  <- \${name%%_*}, longest _* removed from the end"
print "${name%_*}  <- \${name%_*}, shortest _* removed"
print "${name#*_}  <- \${name#*_}, shortest *_ removed from the front"
# endregion: shortest-longest

# region: slice-id
# focus: ${id:0:4} ${id:4:6} ${id: -1}
print "== container numbers, split ISO 6346 style (owner+U, serial, check digit):"
for manifest in $manifests; do
  name=${${manifest##*/}%.json}
  id=${name%%_*}
  print "  ${id:0:4} ${id:4:6} ${id: -1}"
done
# endregion: slice-id

# region: replace
# focus: ${size/45G1/40ft high cube}
print "== gate screen:"
for manifest in $manifests; do
  name=${${manifest##*/}%.json}
  size=${${name#*_}%%_*}
  size=${size/45G1/40ft high cube}
  size=${size/45R1/40ft reefer}
  size=${size/22G1/20ft general}
  print "  ${name%%_*}  ${(r:16:)size}  ${${name##*_}//-/ }"
done
print "as a Dutch customs key: ${manifests[2]//\//:}"
# endregion: replace
