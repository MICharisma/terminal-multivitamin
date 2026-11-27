#!/usr/bin/env zsh
# requires: macos
# Searching text with grep · 13 · Auckland youth orchestra, finding parts with Spotlight
#
# Teaches:
#   - `mdfind 'query'` is Spotlight from the terminal: it searches file contents and metadata
#   - `mdfind -onlyin dir` limits the search; `kMDItemDisplayName == "*finlandia*"c` matches names
#   - Spotlight indexes asynchronously; for a just-written file, `grep -r` is immediate and reliable
#   - `mdls -name kMDItemDisplayName file` shows metadata; `mdfind`/`mdls` are macOS-only
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "spotlight_parts.zsh uses mdfind and mdls, which are macOS tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/apo-youth-auckland.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir parts
print "Violin I, Beethoven Symphony No. 7, movement 2" > parts/violin-1-beethoven-7.txt
print "Viola, Beethoven Symphony No. 7, movement 2"    > parts/viola-beethoven-7.txt
print "Cello, Sibelius Finlandia, cue at bar 40"       > parts/cello-finlandia.txt
print "Violin II, Sibelius Finlandia, divisi at bar 12" > parts/violin-2-finlandia.txt

# region: grep-immediate
# focus: grep -rl Beethoven parts
print "== grep finds Beethoven at once (no index wait):"
grep -rl Beethoven parts | sort
# endregion: grep-immediate

# region: mdfind-name
# focus: mdfind -onlyin
print "== Spotlight name query (may be empty until the index catches up):"
print "  mdfind -onlyin . 'kMDItemDisplayName == \"*finlandia*\"c'"
mdfind -onlyin $PWD 'kMDItemDisplayName == "*finlandia*"c' >/dev/null
print "== grep -rl Finlandia, sure either way:"
grep -rl Finlandia parts | sort
# endregion: mdfind-name

# region: mdfind-content
# focus: mdfind -onlyin $PWD Beethoven
print "== Spotlight content query for Beethoven (often empty on fresh files):"
mdfind -onlyin $PWD Beethoven >/dev/null
print "  (ran mdfind -onlyin \$PWD Beethoven; parts librarian still uses grep for rehearsal folders)"
# endregion: mdfind-content

# region: mdls
# focus: mdls -name kMDItemDisplayName
print "== mdls display name on the cello part:"
print "  $(mdls -name kMDItemDisplayName -raw parts/cello-finlandia.txt)"
# endregion: mdls
