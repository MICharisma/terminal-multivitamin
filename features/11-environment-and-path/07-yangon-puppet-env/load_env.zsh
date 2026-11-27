#!/usr/bin/env zsh
# Environment and PATH · 07 · Yangon puppet theatre, loading the evening show from a .env file
#
# Teaches:
#   - `set -a` (allexport) exports every assignment that follows until `set +a`
#   - `. ./show.env` (or `source`) runs the file in the current shell so the assignments stick
#   - wrap the source in `set -a` / `set +a` so only the file's names are exported, not later locals
#   - a child process then sees `SHOW_TITLE` without an explicit `export` per line
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/marionette-yangon.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/show.env $workdir/
cd -- "$workdir"

print -r -- '#!/usr/bin/env zsh
print "tonight: $SHOW_TITLE at $STAGE, curtain $CURTAIN_TIME"' > announce.zsh
chmod +x announce.zsh

# region: allexport
# focus: set -a
set -a
# endregion: allexport

# region: source-env
# focus: . ./show.env
. ./show.env
set +a
# endregion: source-env

# region: child-sees
# focus: ./announce.zsh
print "== after sourcing under set -a:"
./announce.zsh | sed 's/^/  /'
print "  export -p | grep SHOW:"
export -p | grep SHOW_TITLE | sed 's/^/  /'
# endregion: child-sees

# region: later-local
# focus: set +a
BACKSTAGE=quiet
print "== BACKSTAGE after set +a is not exported:"
if printenv BACKSTAGE >/dev/null; then print "  unexpectedly exported"; else print "  shell=$BACKSTAGE, not in environment"; fi
# endregion: later-local
