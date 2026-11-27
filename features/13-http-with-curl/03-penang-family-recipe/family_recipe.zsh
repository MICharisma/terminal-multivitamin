#!/usr/bin/env zsh
# HTTP with curl · 03 · Penang family laksa recipe
#
# Teaches:
#   - `curl -fsSL` fails loud on HTTP errors (`-f`), stays silent (`-s`), shows
#     curl errors (`-S`), and follows redirects (`-L`)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/penang-laksa.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www/recipes
cp "${0:A:h}/fixtures/laksa-nyonya.txt" www/recipes/laksa-nyonya.txt

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: fail-missing
# focus: curl -fsSL
print "== before auntie posts the recipe"
if curl -fsSL "$base/recipes/missing-card.txt" -o /dev/null 2>/dev/null; then
  print "  unexpected success"
else
  print "  missing card: curl -fsSL failed as expected"
fi
# endregion: fail-missing

# region: fetch-recipe
# focus: curl -fsSL
print "== after the laksa card lands"
curl -fsSL "$base/recipes/laksa-nyonya.txt" | while IFS= read -r line; do
  print "  $line"
done
# endregion: fetch-recipe
