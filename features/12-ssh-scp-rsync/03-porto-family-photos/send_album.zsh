#!/usr/bin/env zsh
# ssh, scp, and rsync · 03 · Porto family photos to grandmother's inbox
#
# Teaches:
#   - `scp` copies one file to a remote path over SSH
#   - `StrictHostKeyChecking accept-new` records the host key on first connect
#   - `UserKnownHostsFile` keeps that record inside the workdir, not `~/.ssh`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/porto-album.XXXXXX")
sshd_pid=
cleanup() {
  [[ -n $sshd_pid ]] && kill $sshd_pid 2>/dev/null
  rm -rf -- "$workdir"
}
trap cleanup EXIT
cd -- "$workdir"

cp -R -- ${0:A:h}/fixtures/fotos-douro .
mkdir -p avo-inbox keys
login=$(id -un)

hostkey=$workdir/ssh_host_ed25519_key
client=$workdir/keys/neto
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

ssh_opts=(-i $client -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new -o UserKnownHostsFile=$workdir/known_hosts -P $port)

# region: before-inbox
# focus: ls -1 avo-inbox
print "== before:"
ls -1 avo-inbox || true
# endregion: before-inbox

# region: scp-photo
# focus: scp "${ssh_opts[@]}" fotos-douro/barco-rabelo.jpg
scp "${ssh_opts[@]}" fotos-douro/barco-rabelo.jpg ${login}@127.0.0.1:$workdir/avo-inbox/
# endregion: scp-photo

# region: known-hosts
# focus: UserKnownHostsFile
print "== UserKnownHostsFile: known_hosts"
print "== known hosts recorded: $([[ -s $workdir/known_hosts ]] && print yes || print no)"
print "== StrictHostKeyChecking: accept-new"
# endregion: known-hosts

# region: after-inbox
# focus: ls -1 avo-inbox
print "== after:"
ls -1 avo-inbox
# endregion: after-inbox
