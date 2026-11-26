#!/usr/bin/env zsh
# ssh, scp, and rsync · 09 · Dhaka payments jumpbox mux
#
# Teaches:
#   - `ControlMaster auto` reuses one SSH connection for later sessions
#   - `ControlPath` names the mux socket (keep it in the workdir)
#   - `ControlPersist` keeps the master alive after the first client exits
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/paylab-mux.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p keys mux
ssh-keygen -t ed25519 -f keys/paylab -N '' -q

# region: write-mux
# focus: ControlMaster auto
cat > ssh_config <<EOF
Host paylab
  HostName paylab.dhaka.internal
  User deploy
  IdentityFile $workdir/keys/paylab
  ControlMaster auto
  ControlPath $workdir/mux/%C
  ControlPersist 10m
EOF
# endregion: write-mux

show_field() {
  local want=$1 label=$2 line key value
  ssh -G -F ssh_config paylab | while IFS= read -r line; do
    key=${line%% *}
    value=${line#* }
    case $key in
      ($want)
        if [[ $want == controlpath ]]; then
          print "$label mux/${value:t}"
        else
          print "$label $value"
        fi
        ;;
    esac
  done
}

# region: resolve-master
# focus: ControlMaster
print "== paylab mux:"
show_field controlmaster ControlMaster
# endregion: resolve-master

# region: resolve-path
# focus: ControlPath
show_field controlpath ControlPath
# endregion: resolve-path

# region: resolve-persist
# focus: ControlPersist
show_field controlpersist ControlPersist
# endregion: resolve-persist
