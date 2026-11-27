#!/usr/bin/env zsh
# Finding files with find and xargs · 09 · Tallinn song festival, one folder per choir and song
#
# Teaches:
#   - `xargs` is not only for `find`: it turns the lines of any plan file into arguments
#   - `xargs -L 1` runs one command per line, still splitting that line into words
#   - `xargs -I {}` takes each whole line, spaces included, and drops it wherever `{}` appears
#   - plain `xargs mkdir` splits "Mu isamaa armas" into three folders
#   - BSD `xargs -I` replaces `{}` in at most five arguments (`-R`); GNU has no such cap
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/laulupidu.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cat > roster.txt <<'ROSTER'
ellerhein soprano
ellerhein alto
tallinna-poistekoor treble
rahvusmeeskoor tenor
rahvusmeeskoor bass
ROSTER
cat > songs.txt <<'SONGS'
Mu isamaa armas
Koit
Ta lendab mesipuu poole
SONGS
print "joint score, Laulupidu 2026, Tallinn Song Festival Grounds" > joint-score.pdf

# region: plain-xargs
# focus: xargs mkdir -p
mkdir split-words && (cd split-words && xargs mkdir -p < ../songs.txt)
made=( split-words/*(/:t) )
print "plain xargs made $#made folders from 3 songs: $made"
# endregion: plain-xargs

# region: one-line-per-command
# focus: xargs -L 1 sh -c 'mkdir -p "parts/$1/$2"' sh
xargs -L 1 sh -c 'mkdir -p "parts/$1/$2"' sh < roster.txt
print "== a folder per choir and voice, one sh run per roster line:"
find parts -mindepth 2 -type d | sort
# endregion: one-line-per-command

# region: whole-line
# focus: xargs -I {} mkdir -p "songs/{}"
xargs -I {} mkdir -p "songs/{}" < songs.txt
print "== a folder per song, spaces kept:"
find songs -mindepth 1 -type d | sort
# endregion: whole-line

# region: placeholder-twice
# focus: xargs -I {} cp joint-score.pdf "songs/{}/{}.pdf"
xargs -I {} cp joint-score.pdf "songs/{}/{}.pdf" < songs.txt
print "== the joint score, copied under each song's name:"
find songs -name '*.pdf' | sort
# endregion: placeholder-twice
