#!/usr/bin/env zsh
# ssh, scp, and rsync · 04 · Chiang Mai Night Bazaar gallery crates
#
# Teaches:
#   - `scp -r` copies a whole folder tree over SSH
#   - a `for` loop ships each exhibition crate the same way
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/night-bazaar-crates.XXXXXX")
sshd_pid=
cleanup() {
  [[ -n $sshd_pid ]] && kill $sshd_pid 2>/dev/null
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

cp -R -- ${0:A:h}/fixtures/crate-lanterns ${0:A:h}/fixtures/crate-silk .
mkdir -p loading-dock keys
login=$(id -un)

hostkey=$workdir/ssh_host_ed25519_key
client=$workdir/keys/curator
ssh-keygen -t ed25519 -f $hostkey -N '' -q
ssh-keygen -t ed25519 -f $client -N '' -q
cp $client.pub $workdir/authorized_keys

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("127.0.0.1",0)); print(s.getsockname()[1]); s.close()')
sftp_server=
for candidate in /usr/libexec/sftp-server /usr/lib/openssh/sftp-server /usr/lib/ssh/sftp-server; do
  [[ -x $candidate ]] && sftp_server=$candidate && break
done
[[ -n $sftp_server ]] || { print -u2 "sftp-server not found"; exit 1 }
cat > $workdir/sshd_config <<EOF
Port $port
ListenAddress 127.0.0.1
HostKey $hostkey
PidFile $workdir/sshd.pid
AuthorizedKeysFile $workdir/authorized_keys
PasswordAuthentication no
KbdInteractiveAuthentication no
UsePAM no
StrictModes no
PubkeyAuthentication yes
Subsystem sftp $sftp_server
EOF
/usr/sbin/sshd -f $workdir/sshd_config -D &
sshd_pid=$!
for _ in {1..50}; do
  python3 -c "import socket; s=socket.socket(); s.settimeout(0.1); s.connect(('127.0.0.1',$port))" 2>/dev/null && break
  sleep 0.05
done

ssh_opts=(-i $client -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -o UserKnownHostsFile=$workdir/known_hosts -P $port)

# region: empty-dock
# focus: ls -1 loading-dock
print "== loading dock before:"
ls -1 loading-dock || true
# endregion: empty-dock

# region: ship-crates
# focus: scp -r
for crate in crate-lanterns crate-silk; do
  scp -r "${ssh_opts[@]}" $crate ${login}@127.0.0.1:$workdir/loading-dock/
done
# endregion: ship-crates

# region: dock-listing
# focus: ls -1 loading-dock
print "== loading dock after:"
ls -1 loading-dock
print "== crate-lanterns:"
ls -1 loading-dock/crate-lanterns
print "== crate-silk:"
ls -1 loading-dock/crate-silk
# endregion: dock-listing
