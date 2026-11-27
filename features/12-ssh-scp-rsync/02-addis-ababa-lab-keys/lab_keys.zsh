#!/usr/bin/env zsh
# ssh, scp, and rsync · 02 · Addis Ababa Institute of Technology lab keys
#
# Teaches:
#   - `ssh-keygen -t ed25519` makes a modern key pair
#   - `-f` sets the private-key path; the public key gets `.pub`
#   - `-N ''` leaves the key unlocked for a lab sandbox
#   - `-C` stores a comment such as `student@aait.edu.et`
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/aait-lab-keys.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p students

# region: mint-key
# focus: ssh-keygen -t ed25519
mint_student_key() {
  emulate -L zsh
  setopt local_options err_return
  local login=$1 comment=$2
  local key=students/$login
  ssh-keygen -t ed25519 -f $key -N '' -C $comment -q
  print "private: ${key:t}"
  print "public:  ${key:t}.pub"
  print "comment: $(awk '{print $3}' $key.pub)"
  print "type:    $(awk '{print $1}' $key.pub)"
}
# endregion: mint-key

# region: issue-hana
# focus: mint_student_key hana-kebede student@aait.edu.et
mint_student_key hana-kebede student@aait.edu.et
# endregion: issue-hana

# region: issue-dawit
# focus: mint_student_key dawit-tesfaye student@aait.edu.et
mint_student_key dawit-tesfaye student@aait.edu.et
# endregion: issue-dawit

# region: lab-roster
# focus: students/*.pub
print "== lab roster:"
ls -1 students/*.pub
# endregion: lab-roster
