# Searching text with grep · 12 · Colombo tea export desk, grading the catalogue, in portable sh

A tea export desk in Colombo grades lots as BOP, BOPF, FBOP, OP and Dust. Portable `sh` sticks to POSIX grep: `-x` matches a whole grade line, `-F -e` builds an OR of leaf grades, `-v` drops Dust, and `if grep -q` handles a quiet no-match.

**What it teaches**

- POSIX `grep` has `-F` `-E` `-i` `-v` `-c` `-l` `-n` `-x`; it does not require GNU extensions
- `grep -x` matches a whole line only: grade `BOP` does not match `BOPF`
- `grep -e` in a loop builds an OR of fixed grades without needing `-E` alternation
- exit status under `set -e` needs `grep … || test $? = 1` (or `if grep`) so "no match" is not a failure

**Lesson steps**

1. Match a whole line with -x (`grep -x`)
2. OR fixed grades with -F -e (`grep -F -e`)
3. Drop Dust with -v (`grep -v`)
4. Handle no-match with if grep -q (`grep -q`)

**Files**

| File | Role |
| --- | --- |
| [`grade_check.sh`](grade_check.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/12-colombo-tea-export/grade_check.sh
tests/run-examples.zsh 12-colombo-tea-export
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
