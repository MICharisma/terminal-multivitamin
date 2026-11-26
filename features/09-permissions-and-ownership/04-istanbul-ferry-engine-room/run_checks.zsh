#!/usr/bin/env zsh
# Permissions and ownership · 04 · Istanbul ferry engine room, the check script that will not run
#
# Teaches:
#   - without the `x` bit, `./bilge_check.sh` fails with exit status 126 (found, not executable)
#   - `sh bilge_check.sh` runs it anyway: the interpreter only needs to read the file
#   - a bare `bilge_check.sh` is 127 (not found): the current folder is not on `PATH`
#   - `chmod u+x` fixes it; a `#!` line with a Windows `\r` gives 127 "bad interpreter"
#   - every folder on the way needs `x` too: without it the script is 126 again
set -o errexit -o nounset -o pipefail

if (( EUID == 0 )); then
  print -u2 "run_checks.zsh: run this as a regular user; root ignores read and write bits"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/sehir-hatlari.XXXXXX")
trap 'chmod -R u+rwx -- "$workdir" 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p checks
print -r -- '#!/bin/sh
echo "bilge pump 2: 38 l/min, float switch ok"' > checks/bilge_check.sh
print -rn -- $'#!/bin/sh\r\necho "port shaft seal: 2 drops/min"\r\n' > checks/shaft_seal.sh
cd checks

try() {
  local outcome
  "$@" > output.txt 2>/dev/null && outcome=0 || outcome=$?
  case $outcome in
    (0)   print "  $* -> exit 0: $(< output.txt)" ;;
    (126) print "  $* -> exit 126: found, but not executable" ;;
    (127) print "  $* -> exit 127: not found (the command, or its #! interpreter)" ;;
    (*)   print "  $* -> failed in some other way" ;;
  esac
  rm -f output.txt
}

# region: no-x-bit
# focus: try ./bilge_check.sh
print "== Kadıköy ferry, engineer's morning checks (mode $(ls -l bilge_check.sh | cut -c1-10)):"
try ./bilge_check.sh
# endregion: no-x-bit

# region: via-interpreter
# focus: try sh bilge_check.sh
try sh bilge_check.sh
# endregion: via-interpreter

# region: not-on-path
# focus: try bilge_check.sh
try bilge_check.sh
# endregion: not-on-path

# region: add-x-bit
# focus: chmod u+x bilge_check.sh
chmod u+x bilge_check.sh
print "== after chmod u+x (mode $(ls -l bilge_check.sh | cut -c1-10)):"
try ./bilge_check.sh
# endregion: add-x-bit

# region: bad-interpreter
# focus: try ./shaft_seal.sh
chmod u+x shaft_seal.sh
print "== shaft_seal.sh came from the Windows laptop in the office:"
try ./shaft_seal.sh
tr -d '\r' < shaft_seal.sh > shaft_seal.unix && mv shaft_seal.unix shaft_seal.sh && chmod u+x shaft_seal.sh
print -r -- "  stripped the \\r characters with tr:"
try ./shaft_seal.sh
# endregion: bad-interpreter

# region: folder-needs-x
# focus: chmod u-x checks
cd -- "$workdir"
chmod u-x checks
print "== the checks folder lost its x bit (mode $(ls -ld checks | cut -c1-10)):"
try ./checks/bilge_check.sh
chmod u+x checks
try ./checks/bilge_check.sh
# endregion: folder-needs-x
