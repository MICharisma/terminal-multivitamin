#!/usr/bin/env zsh
# HTTP with curl · 01 · Valparaíso Saturday ferry timetable
#
# Teaches:
#   - `curl -o` writes the response body to a named file instead of stdout
#   - `curl -sS` stays quiet on progress but still shows errors
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/valparaiso-ferry.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www
cp "${0:A:h}/fixtures/saturday.txt" www/saturday.txt

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: save-timetable
# focus: curl -sS -o
curl -sS -o ferry-saturday.txt "$base/saturday.txt"
print "== saved"
print "  ferry-saturday.txt"
# endregion: save-timetable

# region: show-body
# focus: head -n 2
print "== first crossings"
head -n 2 ferry-saturday.txt | while IFS= read -r line; do
  print "  $line"
done
# endregion: show-body
