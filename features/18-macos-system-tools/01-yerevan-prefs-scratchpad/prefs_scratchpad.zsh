#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 01 · Yerevan prefs scratchpad for a workshop app
#
# Teaches:
#   - `defaults write domain key -string` sets a preference in a throwaway domain
#   - `defaults read domain key` prints it back for the projector
#   - `defaults delete domain` in the EXIT trap removes every key we created
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "prefs_scratchpad.zsh uses defaults, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/yerevan-workshop.XXXXXX")
domain=com.micharisma.multivitamin.yerevan-workshop
trap 'defaults delete "$domain" 2>/dev/null || true; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
mkdir -p "$HOME/Library/Preferences"

# region: write-pref
# focus: defaults write
defaults write $domain cohort -string "cascade-2026"
defaults write $domain seats -int 18
print "wrote domain: $domain"
# endregion: write-pref

# region: read-pref
# focus: defaults read
print "cohort: $(defaults read $domain cohort)"
print "seats: $(defaults read $domain seats)"
# endregion: read-pref

# region: delete-pref
# focus: defaults delete
defaults delete $domain
if defaults read $domain >/dev/null 2>&1; then
  print "domain still present: yes"
else
  print "domain still present: no"
fi
# endregion: delete-pref
