#!/bin/sh
# Environment and PATH · 11 · Baku carpet workshop, editing PATH in portable sh
#
# Teaches:
#   - POSIX `sh` has no `$path` array: prepend with `PATH="$dir:$PATH"` and export it
#   - `command -v name` is the portable locator; `type` and `which` are not reliable in sh
#   - `unset PATH` is a bad idea: the shell may fall back to a default, or find nothing
#   - keep a `DEFAULT_PATH` and rebuild from it when a temporary prepend should end
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/xalca-baku.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p bin
printf '#!/bin/sh\necho knot counter 440\n' > bin/knot_count
chmod +x bin/knot_count

DEFAULT_PATH="/usr/bin:/bin"

# region: prepend
# focus: PATH="$workdir/bin:$DEFAULT_PATH"
PATH="$workdir/bin:$DEFAULT_PATH"
export PATH
echo "== with workshop bin prepended:"
echo "  $(command -v knot_count | sed "s|$workdir|WORK|")"
echo "  $(knot_count)"
# endregion: prepend

# region: restore
# focus: PATH=$DEFAULT_PATH
PATH=$DEFAULT_PATH
export PATH
echo "== restored DEFAULT_PATH:"
if command -v knot_count >/dev/null 2>&1; then
  echo "  knot_count still visible"
else
  echo "  knot_count not on PATH"
fi
# endregion: restore

# region: command-v
# focus: command -v
PATH="$workdir/bin:$DEFAULT_PATH"
export PATH
echo "== command -v ls: $(command -v ls)"
echo "== command -v knot_count: $(command -v knot_count | sed "s|$workdir|WORK|")"
# endregion: command-v
