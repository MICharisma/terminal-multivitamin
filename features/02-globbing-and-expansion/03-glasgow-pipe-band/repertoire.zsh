#!/usr/bin/env zsh
# Globbing and expansion · 03 · Glasgow pipe band repertoire scores
#
# Teaches:
#   - **/ matches any depth of folders, including none
#   - collecting matches into an array and counting them with ${#array}
#   - **/reel/*.ly anchors a recursive search on one folder name
#   - **/ does not follow symlinked folders; ***/ does
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/pipe-band-library.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -a tunes=(
  sets/msr/march/pipe-major-donald-maclean.ly
  sets/msr/strathspey/maggie-cameron.ly
  sets/msr/reel/the-sheepwife.ly
  sets/medley/slow-air/mo-ghile-mear.ly
  sets/medley/jig/the-curlew.ly
  sets/medley/reel/mrs-macpherson-of-inveran.ly
  tuning/tuning-phrase.ly
)
for tune in $tunes; do
  mkdir -p ${tune:h}
  print '\\version "2.24.0"' > $tune
  : > ${tune:r}.pdf
done
ln -s sets/msr worlds-2027-msr

# region: every-score
# focus: scores=( **/*.ly )
scores=( **/*.ly )
print "LilyPond scores in the library: ${#scores}"
# endregion: every-score

# region: anchored-folder
# focus: **/reel/*.ly
print "== every reel, whichever set it sits in:"
print -l **/reel/*.ly
# endregion: anchored-folder

# region: shallow-and-deep
# focus: sets/*/*/*.ly
three_deep=( sets/*/*/*.ly )
tuning_only=( */*.ly )
print "exactly three folders under sets/: ${#three_deep}; one folder deep: ${#tuning_only} (${tuning_only})"
# endregion: shallow-and-deep

# region: follow-links
# focus: ***/*.ly
followed=( ***/*.ly )
print "following the worlds-2027-msr symlink too: ${#followed} (the MSR counted twice)"
# endregion: follow-links
