#!/usr/bin/env zsh
# ssh, scp, and rsync · 11 · Amman campus dashboard tunnel
#
# Teaches:
#   - `LocalForward` maps a local port to a host:port on the far side of SSH
#   - `ssh -G` shows the forward as `localforward` without opening the tunnel
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ju-campus-tunnel.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p keys
ssh-keygen -t ed25519 -f keys/student -N '' -q

# region: write-forward
# focus: LocalForward 18080 localhost:8080
cat > ssh_config <<EOF
Host campus-dashboard
  HostName portal.ju.edu.jo
  User student
  IdentityFile $workdir/keys/student
  LocalForward 18080 localhost:8080
EOF
# endregion: write-forward

# region: resolve-tunnel
# focus: ssh -G -F ssh_config campus-dashboard
print "== campus-dashboard:"
ssh -G -F ssh_config campus-dashboard | while IFS= read -r line; do
  key=${line%% *}
  value=${line#* }
  case $key in
    (hostname) print "HostName $value" ;;
    (user) print "User $value" ;;
    (localforward) print "LocalForward $value" ;;
    (identityfile) print "IdentityFile ${value:t}" ;;
  esac
done
# endregion: resolve-tunnel
