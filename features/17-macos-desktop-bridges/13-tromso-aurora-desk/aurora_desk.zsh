#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 13 · Tromsø aurora desk, bridging a night's report
#
# Teaches:
#   - an associative dispatch table maps action names to bridge tools
#   - `textutil -convert` builds the HTML night card from the plain report
#   - `pbcopy` then a guarded `open` finish the handoff to the morning shift
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "aurora_desk.zsh uses macOS desktop bridges"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tromso-aurora.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

print "Kp=5, arcs over Hellisøy, cameras: 3" > night-report.txt
typeset -a actions
actions=( convert-html copy-alert open-card )

headless=0
[[ $TERM == dumb || ! -t 1 ]] && headless=1

for action in $actions; do
  case $action in
    (convert-html)
      # region: convert-report
      # focus: textutil -convert html
      textutil -convert html -output night-report.html -- night-report.txt
      print "action convert-html: night-report.html"
      # endregion: convert-report
      ;;
    (copy-alert)
      # region: copy-alert
      # focus: pbcopy
      print -n -- "aurora desk: Kp=5 arcs, review night-report.html" | pbcopy
      print "action copy-alert: $(pbpaste)"
      # endregion: copy-alert
      ;;
    (open-card)
      # region: open-card
      # focus: open night-report.html
      if (( headless )); then
        print "would: open night-report.html"
      else
        open night-report.html
      fi
      print "action open-card: night-report.html"
      # endregion: open-card
      ;;
  esac
done
