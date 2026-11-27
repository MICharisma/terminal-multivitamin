#!/usr/bin/env zsh
# HTTP with curl · 10 · Luanda clinic redirect chain
#
# Teaches:
#   - `curl -L` follows Location redirects (here a 302 from /clinic to intake)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/luanda-clinic.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 "${0:A:h}/fixtures/redirect_server.py" "$port" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: without-follow
# focus: curl -sS -o
print "== without following redirects"
code=$(curl -sS -o /dev/null -w '%{http_code}' "$base/clinic")
print "  http_code=$code"
# endregion: without-follow

# region: follow-redirect
# focus: curl -sS -L
print "== with curl -L"
curl -sS -L "$base/clinic" | while IFS= read -r line; do
  print "  $line"
done
# endregion: follow-redirect
