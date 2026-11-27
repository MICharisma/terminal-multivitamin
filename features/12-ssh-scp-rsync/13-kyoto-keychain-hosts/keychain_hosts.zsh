#!/usr/bin/env zsh
# requires: macos
# ssh, scp, and rsync · 13 · Kyoto mokuhanga supplier Keychain hosts
#
# Teaches:
#   - `UseKeychain yes` lets macOS OpenSSH store key passphrases in the Keychain
#   - `AddKeysToAgent yes` loads the key into the agent on first use
#   - `ssh -G` still resolves HostName/User/IdentityFile; the Keychain lines live in the config
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
# Apple's ssh -G omits UseKeychain/AddKeysToAgent; read those from the config file.
typeset -A resolved
while IFS= read -r line; do
  resolved[${line%% *}]=${line#* }
done < <(ssh -G -F ssh_config washi-supplier 2>/dev/null)
config_value() {
  local key=$1 word rest
  while IFS=$' \t' read -r word rest; do
    [[ $word == $key ]] || continue
    print -- $rest
    return
  done < ssh_config
}
print "== washi-supplier:"
print "HostName $resolved[hostname]"
print "User $resolved[user]"
print "IdentityFile ${resolved[identityfile]:t}"
print "UseKeychain $(config_value UseKeychain)"
print "AddKeysToAgent $(config_value AddKeysToAgent)"
# endregion: resolve-keychain
