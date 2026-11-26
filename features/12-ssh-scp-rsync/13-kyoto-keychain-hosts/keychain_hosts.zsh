#!/usr/bin/env zsh
# requires: macos
# ssh, scp, and rsync · 13 · Kyoto mokuhanga supplier Keychain hosts
#
# Teaches:
#   - `UseKeychain yes` lets macOS OpenSSH store key passphrases in the Keychain
#   - `AddKeysToAgent yes` loads the key into the agent on first use
#   - `ssh -G` resolves both settings without opening a connection
set -o errexit -o nounset -o pipefail

if [[ $OSTYPE != darwin* ]]; then
  print -u2 "keychain_hosts.zsh uses UseKeychain, which is a macOS OpenSSH option"
  exit 2
fi

workdir=$(mktemp -d "${TMPDIR:-/tmp}/mokuhanga-ssh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p keys
ssh-keygen -t ed25519 -f keys/washi-supplier -N '' -q

# region: write-keychain
# focus: UseKeychain yes
cat > ssh_config <<EOF
Host washi-supplier
  HostName supplier.washi.kyoto.example
  User printer
  IdentityFile $workdir/keys/washi-supplier
  UseKeychain yes
  AddKeysToAgent yes
EOF
# endregion: write-keychain

# region: resolve-keychain
# focus: ssh -G -F ssh_config washi-supplier
typeset -A resolved
while IFS= read -r line; do
  resolved[${line%% *}]=${line#* }
done < <(ssh -G -F ssh_config washi-supplier)
print "== washi-supplier:"
print "HostName $resolved[hostname]"
print "User $resolved[user]"
print "IdentityFile ${resolved[identityfile]:t}"
print "UseKeychain $resolved[usekeychain]"
print "AddKeysToAgent $resolved[addkeystoagent]"
# endregion: resolve-keychain
