# Searching text with grep · 09 · Quito university thesis, scanning citations

A history thesis at a university in Quito cites Andean potato studies. `-e` lists the supervisor's two required authors; `-f patterns.txt` runs a whole reading-list file; together they show who is cited and who is still missing from the checklist.

**What it teaches**

- `grep -e pat1 -e pat2` matches either pattern (same idea as `pat1|pat2` with `-E`)
- `grep -f patterns.txt` reads one pattern per line from a file
- `-f` and `-e` combine; `-f` is how a bibliography checklist stays editable
- patterns from a file are basic regex unless you add `-F` or `-E`

**Lesson steps**

1. Match either of two patterns with -e (`grep -e`)
2. Read patterns from a file with -f (`grep -f`)
3. Find authors not yet on the list (`grep -e (again)`)
4. Treat the checklist as fixed strings (`grep -Ff`)

**Files**

| File | Role |
| --- | --- |
| [`scan_citations.zsh`](scan_citations.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/chapter-2.txt`](fixtures/chapter-2.txt) | Fixture copied into the script's temp folder |
| [`fixtures/patterns.txt`](fixtures/patterns.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/09-quito-thesis-refs/scan_citations.zsh
tests/run-examples.zsh 09-quito-thesis-refs
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
