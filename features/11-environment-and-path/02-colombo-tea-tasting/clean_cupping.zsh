#!/usr/bin/env zsh
# Environment and PATH · 02 · Colombo tea tasting room, scoring cups in a clean environment
#
# Teaches:
#   - `env -i` starts a command with an empty environment; only what you pass is there
#   - pass `HOME`, `PATH`, and anything else the child needs explicitly after `-i`
#   - without `-i`, a child inherits everything, including a surprising `LANG` from the desk laptop
#   - `env` alone lists the current environment; useful before you wipe it
set -o errexit -o nounset -o pipefail

here=${0:A:h}
workdir=$(mktemp -d "${TMPDIR:-/tmp}/colombo-cupping.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cp -- $here/fixtures/score_cup.sh $workdir/
chmod +x $workdir/score_cup.sh
cd -- "$workdir"

export LANG=si_LK.UTF-8
export CUPPING_NOTE="brioche, citrus"

# region: inherited
# focus: ./score_cup.sh
print "== ordinary run inherits the desk laptop:"
./score_cup.sh | sed -E 's|^PATH=.*|PATH=<inherited desk PATH>|; s|^HOME=.*|HOME=<inherited desk HOME>|; s/^/  /'
# endregion: inherited

# region: env-i
# focus: env -i
print "== env -i with only what the score sheet needs:"
env -i HOME=$workdir PATH=/usr/bin:/bin ./score_cup.sh | sed -E "s|^HOME=.*|HOME=WORK|; s/^/  /"
# endregion: env-i

# region: env-list
# focus: env
print "== env | grep CUPPING (still in this shell):"
env | grep '^CUPPING_' | sed 's/^/  /'
# endregion: env-list
