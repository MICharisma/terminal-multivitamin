#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 12 · Lviv print shop launch agent dry-run
#
# Teaches:
#   - `plutil -lint` checks the spool agent plist
#   - `launchctl print` is shown as a `would:` against `gui/$UID/label`
#   - no bootstrap means no leftover agent on the shop Mac
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "spool_agent.zsh uses plutil/launchctl, macOS tools"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/lviv-print.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

label=com.micharisma.multivitamin.lviv-spool
cat > ${label}.plist <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.micharisma.multivitamin.lviv-spool</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/true</string>
  </array>
</dict>
</plist>
PLIST

# region: lint-spool
# focus: plutil -lint
plutil -lint ${label}.plist >/dev/null
print "lint: ok"
# endregion: lint-spool

# region: would-print
# focus: launchctl print
print "would: launchctl print gui/\$UID/$label"
print "target label: $label"
# endregion: would-print
