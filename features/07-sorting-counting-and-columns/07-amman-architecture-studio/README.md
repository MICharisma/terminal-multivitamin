# Sorting, counting, and columns · 07 · Amman architecture studio, tabulating facade heights

Jabal Al-Weibdeh studio measures tower and plaza facades in a tab-separated log before a client PDF. `column -t` expands tabs into aligned columns for proofreading. Naming the separator with `-s` stays portable between BSD and util-linux for simple TSV tables.

**What it teaches**

- `column -t` aligns columns in fixed-width output; util-linux adds flags BSD lacks
- `column -s $'\t'` names the input separator so spaced columns still align
- both BSD and util-linux accept `-t -s` for simple TSV tables in the lesson

**Lesson steps**

1. Print an aligned table from the TSV (`column -t`)
2. Repeat with an explicit tab separator (`column -t -s $'\t'`)

**Files**

| File | Role |
| --- | --- |
| [`facade_table.zsh`](facade_table.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/facade-measures.tsv`](fixtures/facade-measures.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/07-amman-architecture-studio/facade_table.zsh
tests/run-examples.zsh 07-amman-architecture-studio
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
