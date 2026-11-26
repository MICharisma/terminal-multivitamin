#!/usr/bin/env zsh
# requires: macos
# macOS system tools · 05 · Vilnius backup agent plist lint
#
# Teaches:
#   - a here-document writes a minimal LaunchAgent plist into the sandbox
#   - `plutil -lint` validates the plist without loading it
#   - bootstrap stays a printed `would:` line so no persistent agent remains
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "lint_agent.zsh uses plutil, a macOS tool"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/vilnius-backup.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

label=com.micharisma.multivitamin.vilnius-backup
plist=$workdir/${label}.plist

# region: heredoc-plist
# focus: <<'PLIST'
cat > $plist <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.micharisma.multivitamin.vilnius-backup</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/echo</string>
    <string>vilnius-backup-ok</string>
  </array>
</dict>
</plist>
PLIST
# endregion: heredoc-plist

# region: plutil-lint
# focus: plutil -lint
if plutil -lint $plist >/dev/null; then
  print "plutil -lint: ok"
else
  print "plutil -lint: failed"
  exit 1
fi
print "would: launchctl bootstrap gui/\$UID ${label}.plist"
print "would: launchctl bootout gui/\$UID ${label}.plist"
# endregion: plutil-lint
