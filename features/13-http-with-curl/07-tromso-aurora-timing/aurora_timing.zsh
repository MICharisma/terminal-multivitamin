#!/usr/bin/env zsh
# HTTP with curl · 07 · Tromsø aurora forecast timing
#
# Teaches:
#   - `curl -w` appends write-out fields after the body (use http_code,
#     content_type, size_download — never time_total, which varies)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tromso-aurora.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www
cp "${0:A:h}/fixtures/forecast.json" www/forecast.json

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: write-out
# focus: -w
print "== aurora forecast metrics"
{
  curl -sS -w '\nhttp_code=%{http_code}\ncontent_type=%{content_type}\nsize_download=%{size_download}\n' \
    "$base/forecast.json"
} | while IFS= read -r line; do
  case $line in
    (http_code=*|content_type=*|size_download=*) print "  $line" ;;
    ('') ;;
    (*) print "  body:$line" ;;
  esac
done
# endregion: write-out
