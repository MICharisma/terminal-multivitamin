# Editing streams with sed and awk · 10 · Lyon silk weaving

Atelier Saint-Georges logs each spool: loom, dye lot, metres wound. The foreman counts how many spools share a lot, totals metres per loom, then checks how many lots and looms appear. Associative arrays with `++` and `+=` answer each part; a `case` loop reports the distinct key counts.

**What it teaches**

- awk associative arrays count occurrences with `count[key]++`
- the same array shape can sum a numeric field per key in one pass
- iterating `for (key in arr)` is unordered; pipe through `sort` for a report

**Lesson steps**

1. Count spools per dye lot (`array[key]++`)
2. Sum metres per loom (`array[key] +=`)
3. Report distinct keys through `case` (`case $role in`)

**Files**

| File | Role |
| --- | --- |
| [`silk_reels.zsh`](silk_reels.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/loom-spools.tsv`](fixtures/loom-spools.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/10-lyon-silk-weaving/silk_reels.zsh
tests/run-examples.zsh 10-lyon-silk-weaving
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
