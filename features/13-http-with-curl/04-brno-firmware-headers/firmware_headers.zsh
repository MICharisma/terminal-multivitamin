#!/usr/bin/env zsh
# HTTP with curl · 04 · Brno firmware board headers
#
# Teaches:
#   - `curl -H` sends one or more custom request headers with each call
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/brno-firmware.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 "${0:A:h}/fixtures/echo_headers.py" "$port" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"
typeset -a probes
probes=(
  "alpha-relay|r12"
  "beta-sensor|r7"
  "gamma-motor|r9"
)

# region: header-loop
# focus: curl -sS -H
print "== firmware probes"
for probe in $probes; do
  board=${probe%%|*}
  rev=${probe#*|}
  reply=$(curl -sS -H "X-Board-Id: $board" -H "X-Firmware-Rev: $rev" "$base/probe")
  print "  $reply"
done
# endregion: header-loop
