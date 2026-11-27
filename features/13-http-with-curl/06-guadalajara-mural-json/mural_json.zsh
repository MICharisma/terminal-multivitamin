#!/usr/bin/env zsh
# HTTP with curl · 06 · Guadalajara mural JSON submission
#
# Teaches:
#   - `curl --json` POSTs a JSON body and sets Content-Type: application/json
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/guadalajara-mural.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 "${0:A:h}/fixtures/echo_json.py" "$port" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

typeset -A mural
mural=(
  title    "alegria del barrio"
  district "tlaquepaque"
  panels   "12"
)

# region: json-post
# focus: --json
print "== mural registry"
payload=$(print -r -- "{\"title\":\"$mural[title]\",\"district\":\"$mural[district]\",\"panels\":$mural[panels]}")
reply=$(curl -sS --json "$payload" "$base/murals")
print "  $reply"
# endregion: json-post
