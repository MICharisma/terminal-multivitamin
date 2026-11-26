#!/usr/bin/env zsh
# zsh configuration, aliases, and functions · 13 · Ulaanbaatar library modular zshrc
#
# Teaches:
#   - a modular `.zshrc` `source`s small fragments for aliases, dirs, and keys
#   - `hash -d` / named directories give short `cd ~catalog` jumps for the stacks
#   - `bindkey` wires a widget in the temp ZDOTDIR without touching your keymap
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/ulaanbaatar-library-zsh.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
zdot=$workdir/zdot
mkdir -p $zdot/rc.d stacks/{rare,periodicals}
print "Qing atlas" > stacks/rare/atlas.txt
print "Ub Post 1921" > stacks/periodicals/ub-post.txt

# region: fragments
# focus: source
cat > $zdot/rc.d/10-dirs.zsh <<FRAG
hash -d catalog=$workdir/stacks/rare
hash -d serials=$workdir/stacks/periodicals
FRAG
cat > $zdot/rc.d/20-aliases.zsh <<'FRAG'
alias stacks='print -l rare periodicals'
FRAG
cat > $zdot/rc.d/30-keys.zsh <<'FRAG'
bindkey -s '^g' 'stacks\n'
FRAG
cat > $zdot/.zshrc <<'RC'
for fragment in $ZDOTDIR/rc.d/*.zsh(N); do
  source $fragment
done
RC
# endregion: fragments

# region: named-dirs
# focus: cd ~catalog
print "== named directories after modular load:"
ZDOTDIR=$zdot WORKROOT=$workdir zsh -fc '
  source $ZDOTDIR/.zshrc
  catalog_path=~catalog
  serials_path=~serials
  print "catalog -> ${catalog_path#$WORKROOT/}"
  print "serials -> ${serials_path#$WORKROOT/}"
  cd ~catalog && print "cd ~catalog lands on: ${PWD#$WORKROOT/}"
'
# endregion: named-dirs

# region: bindkey-check
# focus: bindkey
print "== stacks alias via sourced fragment:"
ZDOTDIR=$zdot zsh -ic 'stacks'
print "== ^g is bound:"
ZDOTDIR=$zdot zsh -ic 'bindkey "^g"'
# endregion: bindkey-check
