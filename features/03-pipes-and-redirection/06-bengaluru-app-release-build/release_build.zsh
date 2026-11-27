#!/usr/bin/env zsh
# Pipes and redirection · 06 · Bengaluru delivery app, keeping the release build log
#
# Teaches:
#   - `tee file` writes its input to a file and passes it on, so a pipeline can keep going
#   - `tee` in the middle of a pipeline saves each stage, which is how you debug a long one
#   - `tee -a` appends instead of truncating, for a history across builds
#   - `tee one two >/dev/null` copies to several files and shows nothing
#   - (outside these scripts) `print ... | sudo tee /etc/file` is why `tee` shows up in setup guides:
#     `sudo print > /etc/file` would open the file as you, not as root
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/thali-express-build.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

# Stands in for the Gradle build: one line per module, warnings mixed in.
compile_modules() {
  local module
  for module in checkout menu-search rider-tracking payments-upi checkout loyalty; do
    print "compiled :$module"
    [[ $module == payments-upi ]] && print "WARN :payments-upi uses deprecated UpiIntent API"
    [[ $module == rider-tracking ]] && print "WARN :rider-tracking location permission prompt missing Kannada text"
  done
  print "BUILD SUCCESSFUL, version 4.18.0 (build 912)"
}

# region: save-and-count
# focus: compile_modules | tee build.log | grep -c '^WARN'
warnings=$(compile_modules | tee build.log | grep -c '^WARN')
print "build.log keeps $(( $(wc -l < build.log) )) lines; $warnings warnings went on to grep -c"
# endregion: save-and-count

# region: tap-stages
# focus: tee stage-1-compiled.txt | sort -u | tee stage-2-unique.txt
unique_modules=$(grep '^compiled' build.log | tee stage-1-compiled.txt | sort -u | tee stage-2-unique.txt | wc -l)
print "modules: $(( unique_modules )) unique, from $(( $(wc -l < stage-1-compiled.txt) )) compile lines"
print "== stage 1 shows which module compiled twice: $(sort stage-1-compiled.txt | uniq -d)"
# endregion: tap-stages

# region: append-history
# focus: tee -a release-history.log
for build in 911 912; do
  print "build $build: $warnings warnings, $(tail -n 1 build.log | cut -d, -f1)" | tee -a release-history.log > /dev/null
done
print "== release-history.log after two runs:"
cat release-history.log
# endregion: append-history

# region: fan-out
# focus: tee android-notes.txt ios-notes.txt > /dev/null
grep '^WARN' build.log | tee android-notes.txt ios-notes.txt > /dev/null
print "release notes for both stores: $(( $(cat android-notes.txt ios-notes.txt | wc -l) )) warning lines to triage"
# endregion: fan-out
