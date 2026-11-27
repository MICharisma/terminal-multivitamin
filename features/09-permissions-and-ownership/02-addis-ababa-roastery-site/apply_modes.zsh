#!/usr/bin/env zsh
# Permissions and ownership · 02 · Addis Ababa coffee roastery, setting modes on the web shop
#
# Teaches:
#   - octal modes name all nine bits at once: `chmod 640` is `rw-r-----`, whatever was there before
#   - common web modes: 644 for pages, 755 for scripts and folders, 640 for config, 600 for secrets
#   - `zstat -o +mode` (zsh) reads the mode back as octal on macOS and Linux alike
#   - keeping the plan in an associative array turns "what should it be" into a drift check,
#     and `${+plan[$target]}` finds files nobody planned for
#   - `chmod -R 777` "fixes" an upload error by opening everything; re-applying the plan undoes it
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tomoca-shop.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

zmodload -F zsh/stat b:zstat

mkdir -p shop/{public,cgi-bin,config,uploads}
print "<h1>Yirgacheffe, Guji, Sidama: roasted Tuesday in Piazza</h1>" > shop/public/index.html
print "<p>Order by Thursday for Friday delivery in Bole and Kazanchis</p>" > shop/public/delivery.html
print '#!/bin/sh\necho "Content-Type: text/plain"; echo; echo "beans in stock: 42 kg"' > shop/cgi-bin/stock.cgi
print "currency: ETB\nroast_day: tuesday" > shop/config/shop.yml
print "TELEBIRR_MERCHANT_KEY=tb_live_7d41c9" > shop/config/payment.env

# region: mode-plan
# focus: [shop/config/payment.env]=600
typeset -A plan=(
  [shop]=755              [shop/public]=755        [shop/cgi-bin]=755
  [shop/config]=750       [shop/uploads]=730
  [shop/public/index.html]=644   [shop/public/delivery.html]=644
  [shop/cgi-bin/stock.cgi]=755
  [shop/config/shop.yml]=640     [shop/config/payment.env]=600
)
# endregion: mode-plan

# region: apply-plan
# focus: chmod $plan[$target] $target
apply_plan() {
  local target
  for target in ${(ok)plan}; do
    chmod $plan[$target] $target
  done
}
apply_plan
# endregion: apply-plan

# region: check-drift
# focus: zstat -A mode -o +mode -- $target
check_drift() {
  local target drift=0 mode
  for target in shop/**/*(DN); do
    (( ${+plan[$target]} )) || { print "  $target is not in the plan"; (( ++drift )) }
  done
  for target in ${(ok)plan}; do
    zstat -A mode -o +mode -- $target
    if [[ ${mode[1][-3,-1]} != $plan[$target] ]]; then
      printf '  %-26s is %s, plan says %s (%s)\n' $target ${mode[1][-3,-1]} $plan[$target] \
        "$(zstat -s +mode -- $target)"
      (( ++drift ))
    fi
  done
  (( drift )) || print "  everything matches the plan"
}
print "== after applying the plan:"
check_drift
# endregion: check-drift

# region: panic-fix
# focus: chmod -R 777 shop
print "== the uploads form failed, and someone ran chmod -R 777 shop:"
chmod -R 777 shop
print "%PDF-1.4 order 1043, 3 kg Guji natural" > shop/uploads/order-1043.pdf
check_drift
# endregion: panic-fix

# region: reapply
# focus: apply_plan
apply_plan
print "== plan re-applied:"
check_drift
print "uploads stays 730: the web server's group can drop files in, but cannot list them"
# endregion: reapply
