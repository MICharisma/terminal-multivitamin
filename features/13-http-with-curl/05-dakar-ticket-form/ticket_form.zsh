#!/usr/bin/env zsh
# HTTP with curl · 05 · Dakar festival ticket form
#
# Teaches:
#   - `curl -d` posts application/x-www-form-urlencoded fields
#   - `--data-urlencode` percent-encodes values that contain spaces or punctuation
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/dakar-tickets.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp "${0:A:h}/fixtures/ticket-plan.txt" ticket-plan.txt

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 "${0:A:h}/fixtures/echo_form.py" "$port" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: post-fields
# focus: curl -sS -d
print "== fixed seats hold"
reply=$(curl -sS -d 'artist=Orchestra+Baobab' -d 'night=soundcheck' -d 'seats=1' "$base/hold")
print "  $reply"
# endregion: post-fields

# region: encode-plan
# focus: --data-urlencode
print "== plan file holds"
while IFS='|' read -r artist night seats; do
  reply=$(curl -sS \
    --data-urlencode "artist=$artist" \
    --data-urlencode "night=$night" \
    --data-urlencode "seats=$seats" \
    "$base/hold")
  print "  $reply"
done < ticket-plan.txt
# endregion: encode-plan
