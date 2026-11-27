#!/usr/bin/env bash
# Quoting and parameter expansion · 09 · Florence conservation lab scan names, in bash
#
# Teaches:
#   - in bash (and sh), an unquoted `$scan` is split on spaces and each piece is globbed; zsh does neither
#   - `"$scan"` stays one word, whatever it contains
#   - in a wrapper, `"$@"` forwards each argument intact; `$*` and `$@` re-split them; `"$*"` glues them into one
#   - `printf '%q'` shows how bash would quote a value to type it back in
#   - `${title^^}` needs bash 4; macOS's bash 3.2 falls back to `tr '[:lower:]' '[:upper:]'`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/opificio-scans.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

touch "Botticelli - Primavera detail 03.tif" "Annunciazione *draft*.tif" "Annunciazione detail draft-2.tif"

count_args() { echo "$# argument(s)"; }

# region: unquoted-splits
# focus: count_args $scan
scan="Botticelli - Primavera detail 03.tif"
echo "unquoted \$scan: $(count_args $scan)"
echo "quoted \"\$scan\": $(count_args "$scan")"
# endregion: unquoted-splits

# region: unquoted-globs
# focus: for word in $draft
draft="Annunciazione *draft*.tif"
echo "== unquoted, the * in the name becomes a glob:"
for word in $draft; do
  echo "  [$word]"
done
# endregion: unquoted-globs

# region: forward-args
# focus: "$@"
archive_all()  { count_args "$@"; }
archive_star() { count_args $*; }
archive_glued() { count_args "$*"; }
set -- "Botticelli - Primavera detail 03.tif" "Annunciazione detail draft-2.tif"
echo "two scans through \"\$@\": $(archive_all "$@")"
echo "through \$*:            $(archive_star "$@")"
echo "through \"\$*\":          $(archive_glued "$@")"
# endregion: forward-args

# region: printf-q
# focus: %q
echo "== to type the name back in, quote it like this:"
printf '  %q\n' "$scan"
# endregion: printf-q

# region: uppercase
# focus: ${title^^}
title="primavera, restoration 1982"
if (( BASH_VERSINFO[0] >= 4 )); then
  upper=$(eval 'echo "${title^^}"')
else
  upper=$(echo "$title" | tr '[:lower:]' '[:upper:]')
fi
echo "label for the crate: $upper"
# endregion: uppercase
