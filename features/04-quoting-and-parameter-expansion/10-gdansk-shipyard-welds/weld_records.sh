#!/bin/sh
# Quoting and parameter expansion · 10 · Gdańsk shipyard weld inspections, in portable sh
#
# Teaches:
#   - POSIX `sh` has no arrays; `IFS=:` plus `set -- $record` loads the fields into `$1`, `$2`, ...
#   - `set -f` turns globbing off first, so a field holding `*` stays a star
#   - `${#1}` is a length; `${2#block-}`, `${2%-*}`, and `${4##*-}` trim as in zsh and bash
#   - `"$*"` joins the arguments with the first character of `IFS`
#   - `${5:-none}` fills a blank field; `${3:?message}` stops on a missing required one
set -eu

workdir=$(mktemp -d "${TMPDIR:-/tmp}/stocznia-welds.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cat > welds.txt <<'RECORDS'
W-0412:block-17-hull:pass:2026-11-18:UT
W-0413:block-17-hull:repair:2026-11-18:RT
W-0420:block-21-deck:pass:2026-11-19:*
W-0421:block-21-deck:repair:2026-11-19:
RECORDS
default_ifs=$IFS

# region: split-record
# focus: set -- $record
set -f
record=$(head -n 1 welds.txt)
IFS=:
set -- $record
IFS=$default_ifs
echo "fields: $#; weld $1 on $2, result $3, method $5"
# endregion: split-record

# region: glob-off
# focus: set -f
starred=$(grep '^W-0420' welds.txt)
set +f; IFS=:; set -- $starred; IFS=$default_ifs
echo "globbing on:  the method field became '$5'"
set -f; IFS=:; set -- $starred; IFS=$default_ifs
echo "globbing off: the method field stays '$5' (the inspector's 'see sketch')"
# endregion: glob-off

# region: trim-fields
# focus: ${2%-*}
echo "== inspection board, block by block:"
repairs=
while IFS= read -r record; do
  IFS=:; set -- $record; IFS=$default_ifs
  [ ${#1} -eq 6 ] || echo "  odd weld id: $1"
  echo "  ${2%-*} ${2##*-}  weld ${1#W-}  day ${4##*-}  $3  (${5:-none})"
  [ "$3" = repair ] && repairs="$repairs $1"
done < welds.txt
# endregion: trim-fields

# region: join-with-ifs
# focus: repairs for the night shift: $*
notify_foreman() {
  IFS=,
  echo "repairs for the night shift: $*"
  IFS=$default_ifs
}
notify_foreman $repairs
# endregion: join-with-ifs

# region: required-field
# focus: ${3:?weld $1 has no inspection result}
check_result() { : "${3:?weld $1 has no inspection result}"; }
blank="W-0422:block-21-deck::2026-11-19:VT"
IFS=:; set -- $blank; IFS=$default_ifs
if ! message=$( (check_result "$@") 2>&1 ); then
  echo "stopped: ${message##*: }"
fi
# endregion: required-field
