# Globbing and expansion · 12 · Wellington Cable Car brake logs, in portable sh

The Wellington Cable Car's brake logs are sorted by a script that must run under any `/bin/sh` (dash on Ubuntu, bash-as-sh on macOS). There is no `null_glob` in POSIX sh, so the script guards its loops, counts matches with `set --`, and uses the same glob syntax in `case` to spot an emergency stop and a contractor's log for a car that does not exist.

**What it teaches**

- POSIX `sh` has no `null_glob`: an unmatched glob stays as the literal pattern, so loops guard with `[ -e "$log" ] || continue`
- `set -- pattern` loads matches into `"$@"` and lets you count them with `$#`
- `case` patterns use the same `*` `?` `[ ]` syntax as filename globs, including `[!...]`
- `${log##*/}` and `${name%.log}` trim a path without calling `basename`

**Lesson steps**

1. Guard a POSIX loop against an unmatched glob (`[ -e "$f" ] || continue`)
2. Sort logs with case patterns (`case`)
3. Count matches with set -- (`set -- glob`)
4. See what an unguarded loop receives (`for f in glob`)

**Files**

| File | Role |
| --- | --- |
| [`brake_logs.sh`](brake_logs.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/12-wellington-cable-car/brake_logs.sh
tests/run-examples.zsh 12-wellington-cable-car
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
