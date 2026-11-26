#!/usr/bin/env zsh
# HTTP with curl · 13 · Hobart release manifest
#
# Teaches:
#   - combine `curl -fsSL`, `curl -H`, `curl -w`, and `jq` on one release pull
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/hobart-release.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www/releases
cp "${0:A:h}/fixtures/manifest.json" www/releases/manifest.json

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"
token="harbour-desk-2026"

# region: fetch-manifest
# focus: curl -fsSL
fetch_manifest() {
  local url=$1 auth=$2 out=$3
  curl -fsSL \
    -H "Authorization: Bearer $auth" \
    -H "Accept: application/json" \
    -o "$out" \
    -w '%{http_code}' \
    "$url"
}
# endregion: fetch-manifest

# region: write-status
# focus: http_code=
print "== release pull"
code=$(fetch_manifest "$base/releases/manifest.json" "$token" manifest.json)
print "  http_code=$code"
# endregion: write-status

# region: active-channels
# focus: jq -r
print "== active channels"
jq -r '.channels[] | select(.active) | "\(.name)=\(.version)"' manifest.json | while IFS= read -r row; do
  print "  $row"
done
# endregion: active-channels
