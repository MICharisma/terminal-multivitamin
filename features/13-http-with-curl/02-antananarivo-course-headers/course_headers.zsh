#!/usr/bin/env zsh
# HTTP with curl · 02 · Antananarivo course material headers
#
# Teaches:
#   - `curl -I` asks for headers only (HEAD), without downloading the body
#   - `curl -sI` does the same quietly so you can branch on Content-Type
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/antananarivo-course.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www
cp "${0:A:h}/fixtures/syllabus.json" www/syllabus.json
cp "${0:A:h}/fixtures/reading-list.txt" www/reading-list.txt

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: head-probe
# focus: curl -I
print "== status lines"
curl -I "$base/syllabus.json" 2>/dev/null | tr -d '\r' | head -n 1 | sed 's/^/  /'
curl -I "$base/reading-list.txt" 2>/dev/null | tr -d '\r' | head -n 1 | sed 's/^/  /'
# endregion: head-probe

# region: branch-type
# focus: curl -sI
print "== route by content-type"
for asset in syllabus.json reading-list.txt; do
  ctype=$(curl -sI "$base/$asset" | tr -d '\r' | awk -F': ' 'tolower($1)=="content-type" {print tolower($2); exit}')
  case $ctype in
    (application/json*) print "  $asset -> parse as json ($ctype)" ;;
    (text/plain*)       print "  $asset -> show as text ($ctype)" ;;
    (*)                 print "  $asset -> unknown ($ctype)" ;;
  esac
done
# endregion: branch-type
