# Quoting and parameter expansion · 09 · Florence conservation lab scan names, in bash

A conservation lab at the Opificio delle Pietre Dure in Florence names its scans with spaces, dashes, and the odd `*draft*`. Written in bash to show what zsh quietly refuses to do: an unquoted `$scan` splits and globs, `"$@"` forwards arguments intact, and `printf '%q'` shows the safe spelling.

**What it teaches**

- in bash (and sh), an unquoted `$scan` is split on spaces and each piece is globbed; zsh does neither
- `"$scan"` stays one word, whatever it contains
- in a wrapper, `"$@"` forwards each argument intact; `$*` and `$@` re-split them; `"$*"` glues them into one
- `printf '%q'` shows how bash would quote a value to type it back in
- `${title^^}` needs bash 4; macOS's bash 3.2 falls back to `tr '[:lower:]' '[:upper:]'`

**Lesson steps**

1. See unquoted expansion split on spaces (`unquoted $var`)
2. See unquoted expansion glob on * (`unquoted glob`)
3. Forward arguments with "$@" (`"$@"`)
4. Show the safe spelling with printf %q (`printf %q`)
5. Uppercase a label, with a bash 3.2 fallback (`${var^^}`)

**Files**

| File | Role |
| --- | --- |
| [`scan_names.sh`](scan_names.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/09-florence-conservation-scans/scan_names.sh
tests/run-examples.zsh 09-florence-conservation-scans
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux, in macOS's bash 3.2 as well as newer bash.
