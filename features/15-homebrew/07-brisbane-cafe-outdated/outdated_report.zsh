#!/usr/bin/env zsh
# Homebrew · 07 · Brisbane cafe POS outdated report
#
# Teaches:
#   - `brew outdated --json=v1` lists formulae with a newer stable version
#   - a function wrapped in `emulate -L zsh` keeps `setopt` changes local
#   - the report is read-only: nothing is upgraded on the cafe iPads' host Mac
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/paddo-cafe-brew.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -R -- $here/fixtures/. $workdir/
cd -- "$workdir"
PATH=$workdir/bin:$PATH

# region: report-fn
# focus: emulate -L zsh
report_outdated() {
  emulate -L zsh
  setopt local_options err_return
  local json
  json=$(brew outdated --json=v1)
  print "$json" | python3 -c '
import json, sys
rows = json.load(sys.stdin)
if not rows:
    print("all formulae current")
else:
    for row in rows:
        print(f"{row["name"]}: {row["installed_versions"][0]} -> {row["current_version"]}")
'
}
# endregion: report-fn

# region: run-report
# focus: report_outdated
print "== Monday opening checklist:"
report_outdated
# endregion: run-report
