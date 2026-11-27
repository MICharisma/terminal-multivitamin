# Quoting and parameter expansion · 10 · Gdańsk shipyard weld inspections, in portable sh

Weld inspectors at a Gdańsk shipyard log each check as a colon-separated record. Portable `sh` has no arrays, so `set -f` and `IFS=:` load the fields into `$1`…`$5`, trims peel the block and the day, `"$*"` joins the repairs for the night shift, and `${3:?...}` stops on a blank result.

**What it teaches**

- POSIX `sh` has no arrays; `IFS=:` plus `set -- $record` loads the fields into `$1`, `$2`, ...
- `set -f` turns globbing off first, so a field holding `*` stays a star
- `${#1}` is a length; `${2#block-}`, `${2%-*}`, and `${4##*-}` trim as in zsh and bash
- `"$*"` joins the arguments with the first character of `IFS`
- `${5:-none}` fills a blank field; `${3:?message}` stops on a missing required one

**Lesson steps**

1. Load fields into $1..$5 with set and IFS (`set -- $record`)
2. Turn globbing off so * stays a star (`set -f`)
3. Trim block and day from the fields (`${var%pattern}`)
4. Join repairs with IFS and "$*" (`"$*"`)
5. Stop when the result field is missing (`${var:?message}`)

**Files**

| File | Role |
| --- | --- |
| [`weld_records.sh`](weld_records.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/10-gdansk-shipyard-welds/weld_records.sh
tests/run-examples.zsh 10-gdansk-shipyard-welds
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
