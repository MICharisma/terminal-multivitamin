#!/usr/bin/env zsh
# ssh, scp, and rsync · 10 · Riga open-data bastion hop
#
# Teaches:
#   - `ProxyJump` reaches an inner host through a bastion in one hop
#   - table-driven Host blocks keep the bastion and the target side by side
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/rigatech-bastion.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p keys
ssh-keygen -t ed25519 -f keys/bastion -N '' -q
ssh-keygen -t ed25519 -f keys/opendata -N '' -q

# region: host-rows
# focus: typeset -a host_rows
typeset -a host_rows
host_rows=(
  'bastion bastion.rigatech.gov.lv operator keys/bastion -'
  'opendata data.rigatech.gov.lv curator keys/opendata bastion'
)
# endregion: host-rows

# region: write-hosts
# focus: ProxyJump
: > ssh_config
for row in $host_rows; do
  print -r -- $row | read -r alias hostname user identity jump
  {
    print "Host $alias"
    print "  HostName $hostname"
    print "  User $user"
    print "  IdentityFile $workdir/$identity"
    if [[ $jump != - ]]; then
      print "  ProxyJump $jump"
    fi
  } >> ssh_config
done
# endregion: write-hosts

# region: resolve-jump
# focus: ssh -G -F ssh_config opendata
print "== opendata via bastion:"
ssh -G -F ssh_config opendata | while IFS= read -r line; do
  key=${line%% *}
  value=${line#* }
  case $key in
    (hostname) print "HostName $value" ;;
    (user) print "User $value" ;;
    (proxyjump) print "ProxyJump $value" ;;
    (identityfile) print "IdentityFile ${value:t}" ;;
  esac
done
# endregion: resolve-jump
