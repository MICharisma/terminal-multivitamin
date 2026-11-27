# Editing streams with sed and awk · 13 · Vientiane temple palm-leaf archive

Wat Pha That Luang digitized palm-leaf bundles with angle-bracket tags in the export. Restorers normalize tags to pipes with `sed`, repair slipped leaf-count fields in `awk`, and print per-shelf totals for the workshop. The capstone chains both tools and a local summary function.

**What it teaches**

- `sed` can transliterate angle tags; `awk` can repair fields when a delimiter slipped
- piping `sed` into `awk` keeps one pass for cleanup and another for aggregation
- a capstone report mixes literal `sed` edits with an awk summary table

**Lesson steps**

1. Transliterate angle tags to pipes (`sed -e 's/<tag>/|/g'`)
2. Repair leaf counts and scribe fields (`awk -F'|'`)
3. Sum bundles and leaves per shelf (`awk END`)

**Files**

| File | Role |
| --- | --- |
| [`palm_leaf_archive.zsh`](palm_leaf_archive.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/raw-shelf-export.txt`](fixtures/raw-shelf-export.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/13-vientiane-temple-palm-leaf-archive/palm_leaf_archive.zsh
tests/run-examples.zsh 13-vientiane-temple-palm-leaf-archive
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
