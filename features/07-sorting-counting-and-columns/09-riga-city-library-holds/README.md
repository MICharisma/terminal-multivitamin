# Sorting, counting, and columns · 09 · Riga city library, auditing holds against the patron directory

At the central library in Riga, the holds shelf and the patron directory both key on a library card number, but they drift apart: some holds sit for cards that left the city, and some new patrons have no hold yet. `join` needs both lists sorted on that card number. An inner join finds the agreements; `-v1` and `-v2` name each side's leftovers, which together are the outer join — without relying on GNU-only `-o auto`.

**What it teaches**

- `join` needs both files sorted on the join field; `sort -k1,1` prepares them
- plain `join` is an inner join: only cards present in both files
- `join -v1` lists left-only rows; `join -v2` lists right-only rows
- together, the matches plus both `-v` lists are an outer join, without GNU `-o auto`

**Lesson steps**

1. Join the matching cards after sorting both lists (`join -t`)
2. Build the outer view with matches plus both -v lists (`join -v2`)
3. List shelf holds with no patron record (`join -v1`)

**Files**

| File | Role |
| --- | --- |
| [`hold_audit.zsh`](hold_audit.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/holds-on-shelf.tsv`](fixtures/holds-on-shelf.tsv) | Fixture copied into the script's temp folder |
| [`fixtures/patron-directory.tsv`](fixtures/patron-directory.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/09-riga-city-library-holds/hold_audit.zsh
tests/run-examples.zsh 09-riga-city-library-holds
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
