#!/usr/bin/env zsh
# HTTP with curl · 08 · Colombo tea auction retry
#
# Teaches:
#   - `curl --retry` repeats the request after transient HTTP failures (503 here)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/colombo-tea.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 "${0:A:h}/fixtures/retry_server.py" "$port" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: retry-lot
# focus: --retry
print "== tea lot sheet"
(
  # -f makes each 503 a hard fail that --retry can repeat; stderr stays quiet
  curl -sS -f --retry 5 --retry-delay 0 --retry-max-time 20 "$base/lot" 2>/dev/null
) | while IFS= read -r line; do
  print "  $line"
done
# endregion: retry-lot
