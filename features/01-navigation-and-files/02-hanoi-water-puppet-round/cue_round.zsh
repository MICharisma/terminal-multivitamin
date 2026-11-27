#!/usr/bin/env zsh
# Navigation and files · 02 · Hanoi water puppet theatre pre-show round
#
# Teaches:
#   - `pushd` moves into a folder and remembers where you came from
#   - `$dirstack` is zsh's directory stack as an array; `:t` trims each entry
#   - `popd` walks back one stop at a time; `cd -` jumps to the previous folder
#   - `pushd -q` keeps the stack quiet so the script prints only what it means to
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/thang-long-theatre.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

mkdir -p san-khau/con-roi/sua-chua san-khau/nhac/cue san-khau/den
print "Chú Tễu: repaint the grin, re-tie the left arm string" > san-khau/con-roi/sua-chua/toi-nay.txt
print "cue 7: đàn bầu enters as the dragon surfaces"          > san-khau/nhac/cue/toi-nay.txt
print "lamp 3 over the pagoda is flickering"                  > san-khau/den/toi-nay.txt

stack_line() {
  local -a stops=( ${dirstack:t} )
  print "stack: ${PWD:t} <- ${(j: <- :)stops}"
}

cd san-khau

# region: push-repairs
# focus: pushd -q con-roi/sua-chua
pushd -q con-roi/sua-chua
print "puppets: $(< toi-nay.txt)"
stack_line
# endregion: push-repairs

# region: push-more
# focus: pushd -q ../../nhac/cue
pushd -q ../../nhac/cue
print "music:   $(< toi-nay.txt)"
pushd -q ../../den
print "lights:  $(< toi-nay.txt)"
stack_line
# endregion: push-more

# region: pop-back
# focus: popd -q
popd -q
print "back in ${PWD:t}"
popd -q
popd -q
print "back in ${PWD:t}, stack depth ${#dirstack}"
# endregion: pop-back

# region: toggle-previous
# focus: cd -
cd nhac/cue
cd - >/dev/null
print "cd - returned to ${PWD:t}"
cd - >/dev/null
print "cd - again: ${PWD:t}"
# endregion: toggle-previous
