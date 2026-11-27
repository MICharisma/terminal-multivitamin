#!/usr/bin/env zsh
# HTTP with curl · 09 · Stuttgart parts catalog download
#
# Teaches:
#   - `curl -O` writes the body to a file named after the remote path's final
#     segment (bearing-6204.txt, seal-nitrile.txt)
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/stuttgart-parts.XXXXXX")
trap 'kill ${server_pid:-} 2>/dev/null; rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p www/catalog
cp "${0:A:h}/fixtures/bearing-6204.txt" www/catalog/bearing-6204.txt
cp "${0:A:h}/fixtures/seal-nitrile.txt" www/catalog/seal-nitrile.txt

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
python3 -m http.server "$port" --bind 127.0.0.1 --directory "$workdir/www" &
server_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

base="http://127.0.0.1:${port}"
parts=(bearing-6204.txt seal-nitrile.txt)

# region: remote-name
# focus: curl -sS -O
print "== catalog downloads"
() {
  emulate -L zsh
  local part
  for part in "$@"; do
    curl -sS -O "$base/catalog/$part"
    print "  saved ${part:t}"
  done
} $parts
# endregion: remote-name

# region: list-saved
# focus: ls
print "== workdir sheets"
ls -1 *.txt | while IFS= read -r sheet; do
  print "  $sheet"
done
# endregion: list-saved
