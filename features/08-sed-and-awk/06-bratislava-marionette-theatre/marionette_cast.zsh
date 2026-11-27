#!/usr/bin/env zsh
# Editing streams with sed and awk · 06 · Bratislava marionette theatre
#
# Teaches:
#   - `awk '{print $n}'` pulls the nth field from each line
#   - `awk -F'|' '...'` sets the input field separator
#   - assigning `OFS` in an action changes the output separator between fields
#   - built-in `NF` is the field count on the current line
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/bll-marionettes.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp -- ${0:A:h}/fixtures/cast-roster.txt ${0:A:h}/fixtures/cue-notes.txt .

# region: field-number
# focus: awk '{print $1, $3}'
print "== puppet and role for the poster:"
awk '{print $1, $3}' cast-roster.txt
# endregion: field-number

# region: fs
# focus: awk -F'|'
print "== split the pipe-delimited cue sheet:"
awk -F'|' '{print $2}' cue-notes.txt
# endregion: fs

# region: ofs-nf
# focus: -v OFS='|'
print "== cue count and handler, rejoined with |:"
awk -F'|' -v OFS='|' '{print NF, $2, $3}' cue-notes.txt
# endregion: ofs-nf