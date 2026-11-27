#!/usr/bin/env zsh
# Quoting and parameter expansion · 02 · Montréal theatre, building the surtitle cue file
#
# Teaches:
#   - `$'...'` (ANSI-C quoting) turns `\t`, `\n`, and `\'` into a real tab, newline, and quote
#   - `'\t'` is two characters, backslash and t; `$'\t'` is one
#   - `IFS=$'\t' read -r` splits a tab-separated line, keeping the spaces inside each field
#   - `$'\xc3\xa9'` writes the bytes of é in any locale; `$'\u00e9'` needs a UTF-8 locale and
#     fails under `LC_ALL=C`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/surtitres-tnm.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# region: tab-or-not
# focus: $'\t'
plain='\t' ansi=$'\t'
print -r -- "'\t' is ${#plain} characters, \$'\t' is ${#ansi}"
# endregion: tab-or-not

# region: bytes-not-code-points
# focus: e_acute=$'\xc3\xa9'
e_acute=$'\xc3\xa9'
if ! ( LC_ALL=C; eval "print -r -- \$'\\u00e9'" ) 2>/dev/null; then
  print -r -- "under LC_ALL=C, \$'\u00e9' is refused; \$'\xc3\xa9' gives th${e_acute}"
fi
# endregion: bytes-not-code-points

# region: build-cues
# focus: $'14\tTu es en retard.\tYou are late.'
print -r -- $'14\tTu es en retard.\tYou are late.' > cues.tsv
print -r -- $'15\tJe t\'attendais depuis une heure.\tI waited for you for an hour.' >> cues.tsv
print -r -- "16"$'\t'"Le th${e_acute} ${e_acute}tait froid."$'\t'"The tea was cold." >> cues.tsv
print "cues.tsv: $(( $(wc -l < cues.tsv) )) cues, $(( $(tr -cd '\t' < cues.tsv | wc -c) )) tabs"
# endregion: build-cues

# region: split-on-tab
# focus: IFS=$'\t' read -r cue french english
while IFS=$'\t' read -r cue french english; do
  print -r -- "cue $cue  FR: $french  EN: $english"
done < cues.tsv
# endregion: split-on-tab

# region: two-line-surtitle
# focus: $'Je t\'attendais\ndepuis une heure.'
surtitle=$'Je t\'attendais\ndepuis une heure.'
print "a surtitle screen holds two lines; this one has ${#${(f)surtitle}}:"
print -r -- $surtitle | sed 's/^/  > /'
# endregion: two-line-surtitle
