# Searching text with grep · 11 · Phnom Penh irrigation logs, Perl regex and ripgrep notes, in bash

Irrigation gates on canals outside Phnom Penh log depth and opening every hour. Written in bash to show `grep -P` (Perl regex) where GNU provides it, a `grep -E` fallback on BSD/macOS, and a note on `ripgrep` for the same job on a bigger tree.

**What it teaches**

- `grep -P` uses Perl-compatible regex (lookbehind, `\d`); GNU grep has it, BSD/macOS grep does not
- detect with `grep -P . <<<x`; fall back to `grep -E` when `-P` is missing
- `ripgrep` (`rg`) is a faster recursive search with `--pcre2` for Perl regex; same idea, different tool
- this slot is bash so the `<<<` here-string and the arrays stay familiar on macOS's bash 3.2

**Lesson steps**

1. Detect whether grep -P works (`grep -P`)
2. Pull depths with \d or the -E fallback (`grep -Po`)
3. Try a lookbehind for gate openings (`grep -P lookbehind`)
4. Note ripgrep as a faster recursive search (`rg`)

**Files**

| File | Role |
| --- | --- |
| [`scan_levels.sh`](scan_levels.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/11-phnom-penh-irrigation-logs/scan_levels.sh
tests/run-examples.zsh 11-phnom-penh-irrigation-logs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux, in macOS's bash 3.2 as well as newer bash.
