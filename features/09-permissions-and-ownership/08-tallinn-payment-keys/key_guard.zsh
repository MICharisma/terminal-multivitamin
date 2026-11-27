#!/usr/bin/env zsh
# Permissions and ownership · 08 · Tallinn payments startup, refusing keys that are too open
#
# Teaches:
#   - a mode is a number: `(( mode & 8#077 ))` is non-zero when group or others have any bit
#   - `8#077` is zsh's base notation; `printf %04o` prints the result the way ssh does
#   - `[[ -O file ]]` checks that you own it; `(( dir_mode & 8#022 ))` catches a folder others can write
#   - `chmod go=` clears every group and others bit in one clause, whatever they were
#   - a guard function that returns non-zero reads naturally in `if ! key_is_private ...`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/rahakott-keys.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

zmodload -F zsh/stat b:zstat
mkdir keys
for bank in lhv-live seb-sandbox swedbank-live; do
  print -l -- "-----BEGIN PRIVATE KEY-----" "MC4CAQAwBQYDK2VwBCIEI${bank//-/}" "-----END PRIVATE KEY-----" > keys/$bank.pem
done
chmod 600 keys/lhv-live.pem
chmod 640 keys/seb-sandbox.pem
chmod 644 keys/swedbank-live.pem
chmod 755 keys

# region: guard
# focus: (( mode & 8#077 ))
key_is_private() {
  local key=$1 mode
  mode=$(zstat +mode -- $key)
  [[ -O $key ]] || { print "  $key: not owned by you"; return 1 }
  if (( mode & 8#077 )); then
    printf "  Permissions %04o for '%s' are too open.\n" $(( mode & 8#7777 )) $key
    return 1
  fi
}
# endregion: guard

# region: check-folder
# focus: (( dir_mode & 8#022 ))
folder_is_safe() {
  local dir_mode
  dir_mode=$(zstat +mode -- $1)
  if (( dir_mode & 8#022 )); then
    printf "  folder %s is %04o: others could swap a key\n" $1 $(( dir_mode & 8#7777 ))
    return 1
  fi
}
# endregion: check-folder

# region: refuse
# focus: if ! key_is_private $key
print "== payout run, 08:00 Tallinn time:"
for key in keys/*.pem; do
  if ! key_is_private $key; then
    print "  refusing to sign payouts with ${key:t:r}"
  else
    print "  ${key:t:r}: private, signing"
  fi
done
# endregion: refuse

# region: tighten
# focus: chmod go= $key
chmod 777 keys
print "== an intern ran chmod 777 keys while debugging:"
folder_is_safe keys || chmod go-w keys
for key in keys/*.pem; do
  key_is_private $key > /dev/null || chmod go= $key
done
print "== after chmod go= and chmod go-w:"
folder_is_safe keys && print "  keys/ is $(zstat -s +mode -- keys)"
for key in keys/*.pem; do
  key_is_private $key && print "  ${key:t} $(zstat -s +mode -- $key): ready to sign"
done
# endregion: tighten
