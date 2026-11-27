# Sorting, counting, and columns · 04 · Phnom Penh silk cooperative, matching weavers to dye lots

At Champey silk cooperative in Phnom Penh, the office keeps a CSV of weavers and a second CSV of dye lots keyed by weaver id. Shipping needs one combined row per weaver. `join` only works when both files are sorted on the join field, and comma-separated data needs `join -t,` instead of the default blanks.

**What it teaches**

- `join` only pairs lines when both files are sorted on the join field
- an unsorted second file makes join complain and can skip rows, even if `errexit` hides it
- `sort -t, -k1,1` sorts on the first comma field before a join on that key
- `join -t,` sets the field separator; without `-t` join expects blanks between columns

**Lesson steps**

1. See join fail on unsorted weaver and lot lists (`join -t,`)
2. Sort on the first field before joining (`sort -t, -k1,1`)
3. Join the sorted tables on weaver id (`join -t, -1 1 -2 1`)

**Files**

| File | Role |
| --- | --- |
| [`weave_match.zsh`](weave_match.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/lots.csv`](fixtures/lots.csv) | Fixture copied into the script's temp folder |
| [`fixtures/weavers.csv`](fixtures/weavers.csv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/04-phnom-penh-silk-cooperative/weave_match.zsh
tests/run-examples.zsh 04-phnom-penh-silk-cooperative
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
