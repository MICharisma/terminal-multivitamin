#!/usr/bin/env zsh
# ssh, scp, and rsync · 01 · Tallinn sprint staging hosts
#
# Teaches:
#   - a `Host` alias in an ssh config is the short name you type
#   - `HostName`, `User`, and `IdentityFile` fill in the real connection details
#   - `ssh -G -F config alias` prints the resolved settings without connecting
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/bolt-lab-hosts.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p keys
ssh-keygen -t ed25519 -f keys/staging-eu -N '' -q
ssh-keygen -t ed25519 -f keys/staging-us -N '' -q

# region: host-table
# focus: typeset -A staging_hosts
typeset -A staging_hosts
staging_hosts=(
  staging-eu 'staging-eu.internal.bolt-lab.ee deploy keys/staging-eu'
  staging-us 'staging-us.internal.bolt-lab.ee deploy keys/staging-us'
)
# endregion: host-table

# region: write-config
# focus: Host $alias
config=$workdir/ssh_config
: > $config
for alias in ${(ko)staging_hosts}; do
  print -r -- "$staging_hosts[$alias]" | read -r hostname user identity
  cat >> $config <<EOF
Host $alias
  HostName $hostname
  User $user
  IdentityFile $workdir/$identity
EOF
done
# endregion: write-config

# region: resolve-eu
# focus: ssh -G -F $config staging-eu
print "== staging-eu"
ssh -G -F $config staging-eu | while IFS= read -r line; do
  key=${line%% *}
  value=${line#* }
  case $key in
    (hostname) print "HostName $value" ;;
    (user) print "User $value" ;;
    (identityfile) print "IdentityFile ${value:t}" ;;
  esac
done
# endregion: resolve-eu

# region: resolve-us
# focus: ssh -G -F $config staging-us
print "== staging-us"
ssh -G -F $config staging-us | while IFS= read -r line; do
  key=${line%% *}
  value=${line#* }
  case $key in
    (hostname) print "HostName $value" ;;
    (user) print "User $value" ;;
    (identityfile) print "IdentityFile ${value:t}" ;;
  esac
done
# endregion: resolve-us
