#!/usr/bin/env zsh
# HTTP with curl · 11 · Da Nang hotel folio upload
#
# Teaches:
#   - `curl -F` builds a multipart/form-data body (file fields use @path)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/danang-hotel.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cp "${0:A:h}/fixtures/guest-card.txt" guest-card.txt

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 "${0:A:h}/fixtures/echo_upload.py" "$port" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"

# region: multipart-upload
# focus: curl -sS -F
upload_folio() {
  emulate -L zsh
  setopt local_options err_return
  local card=$1
  curl -sS -F "folio=@${card};type=text/plain" -F "desk=front-office" "$base/folios"
}

print "== guest folio"
upload_folio guest-card.txt | while IFS= read -r line; do
  print "  $line"
done
# endregion: multipart-upload
