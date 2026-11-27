#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 07 · Recife bloco rehearsal callouts
#
# Teaches:
#   - an associative array holds voice → callout pairs
#   - `for voice line in ${(kv)callouts}` walks keys and values together
#   - `say -v` picks a macOS voice; headless mode prints the command instead of playing audio
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "bloco_callouts.zsh uses say, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/bloco-da-torre.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

typeset -A callouts
# Built-in voices so an interactive run does not fail on a missing locale voice.
callouts=(
  Alex     "Atenção, surdo na frente"
  Samantha "Agora o frevo, todo mundo"
)

headless=0
[[ $TERM == dumb || ! -t 1 ]] && headless=1

# region: kv-walk
# focus: ${(kv)callouts}
print "== rehearsal callouts:"
typeset -A snapshot
snapshot=( ${(kv)callouts} )
# endregion: kv-walk

# region: say-voice
# focus: say -v
for voice in ${(ok)snapshot}; do
  line=$snapshot[$voice]
  if (( headless )); then
    print "would: say -v $voice -- $line"
  else
    say -v $voice -- $line
  fi
  print "queued: $voice"
done
# endregion: say-voice

# region: headless-say
# focus: headless
print "headless guard: $( (( headless )) && print on || print off )"
# endregion: headless-say
