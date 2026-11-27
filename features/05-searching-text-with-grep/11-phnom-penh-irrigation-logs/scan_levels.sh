#!/usr/bin/env bash
# Searching text with grep · 11 · Phnom Penh irrigation logs, Perl regex and ripgrep notes, in bash
#
# Teaches:
#   - `grep -P` uses Perl-compatible regex (lookbehind, `\d`); GNU grep has it, BSD/macOS grep does not
#   - detect with `grep -P . <<<x`; fall back to `grep -E` when `-P` is missing
#   - `ripgrep` (`rg`) is a faster recursive search with `--pcre2`; the tip prints either way so CI stays deterministic
#   - this slot is bash so the `<<<` here-string and the arrays stay familiar on macOS's bash 3.2
set -o errexit -o nounset -o pipefail

workdir=$(mktemp -d "${TMPDIR:-/tmp}/tonle-sap-irrigation.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"

cat > levels.log <<'LOG'
06:00 canal-A depth 1.20m gate 40%
07:00 canal-A depth 1.35m gate 55%
08:00 canal-B depth 0.95m gate 30% WARN low
09:00 canal-A depth 1.50m gate 70%
10:00 canal-B depth 1.10m gate 45%
11:00 canal-A depth 1.05m gate 35% WARN low
LOG

# region: detect-p
# focus: grep -P .
if grep -P . <<<x >/dev/null 2>&1; then
  have_p=1
  echo "grep -P: available (GNU)"
else
  have_p=0
  echo "grep -P: missing (BSD/macOS); falling back to grep -E"
fi
# endregion: detect-p

# region: digits
# focus: depth \d+\.\d+m
echo "== depths recorded this morning:"
if (( have_p )); then
  grep -Po 'depth \d+\.\d+m' levels.log
else
  grep -Eo 'depth [0-9]+\.[0-9]+m' levels.log
fi
# endregion: digits

# region: lookbehind
# focus: (?<=gate )\d+
echo "== gate openings as bare percentages:"
if (( have_p )); then
  grep -Po '(?<=gate )\d+' levels.log | tr '\n' ' '; echo
else
  grep -Eo 'gate [0-9]+' levels.log | grep -Eo '[0-9]+' | tr '\n' ' '; echo
fi
# endregion: lookbehind

# region: ripgrep-note
# focus: command -v rg
# Output stays the same whether or not rg is installed, so CI and laptops agree.
warns=$(grep -c 'WARN low' levels.log)
if command -v rg >/dev/null 2>&1; then
  rg_hits=$(rg -N 'WARN low' levels.log | wc -l | tr -d ' ')
  [[ "$rg_hits" == "$warns" ]] || { echo "rg and grep -c disagree"; exit 1; }
fi
echo "WARN lines by plain grep: $warns"
echo "ripgrep tip: brew install ripgrep / apt install ripgrep (same count via rg -N when present)"
# endregion: ripgrep-note
