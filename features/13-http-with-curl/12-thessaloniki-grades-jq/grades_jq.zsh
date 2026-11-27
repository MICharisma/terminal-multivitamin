#!/usr/bin/env zsh
# HTTP with curl · 12 · Thessaloniki grade roster with jq
#
# Teaches:
#   - `jq -r` prints raw strings without JSON quotes
#   - `jq` filters and projects nested JSON fields
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/thessaloniki-grades.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www
cp "${0:A:h}/fixtures/roster.json" www/roster.json

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: list-names
# focus: jq -r
print "== choir roll"
curl -sS "$base/roster.json" | jq -r '.students[].name' | while IFS= read -r name; do
  print "  $name"
done
# endregion: list-names

# region: filter-passing
# focus: select(.grade >= 15)
print "== passing (grade >= 15)"
curl -sS "$base/roster.json" | jq -r '.students[] | select(.grade >= 15) | "\(.name)=\(.grade)"' | while IFS= read -r row; do
  print "  $row"
done
# endregion: filter-passing
