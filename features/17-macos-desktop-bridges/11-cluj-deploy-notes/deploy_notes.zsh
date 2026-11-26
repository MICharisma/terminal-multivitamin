#!/usr/bin/env zsh
# requires: macos
# macOS desktop bridges · 11 · Cluj-Napoca deploy notes on the pasteboard
#
# Teaches:
#   - process substitution `<(...)` exposes a command's output as a file
#   - `pbcopy < <(print ...)` loads the pasteboard without a leftover notes file
#   - `pbpaste` confirms the deploy summary before anyone hits paste in Slack
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "deploy_notes.zsh uses pbcopy/pbpaste, macOS pasteboard tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/cluj-deploy.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

release=2026.11.26-transilvania
services=( api-gateway billing-worker )

# region: process-sub
# focus: <(
notes_file=<(
  print "release: $release"
  print "services:"
  print -l -- $services
  print "migrate: yes"
)
# endregion: process-sub

# region: copy-notes
# focus: pbcopy
pbcopy < $notes_file
print "deploy notes copied"
# endregion: copy-notes

# region: confirm-paste
# focus: pbpaste
print "== pasteboard:"
pbpaste
# endregion: confirm-paste
