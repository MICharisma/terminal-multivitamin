# Sorting, counting, and columns · 06 · Dhaka garment packing, lining up carton labels

Ashulia packing lines keep carton ids, sizes, and colours in three parallel files, one value per line. The laser printer needs them merged into columns or one-line summaries. `paste` joins lines side by side, `-d` picks a delimiter, and `-s` serial mode collapses a file onto one row.

**What it teaches**

- `paste` merges lines from files side by side, column by column
- `paste -d:` uses one delimiter between merged fields
- `paste -s` serial mode turns each file into one row (or transposes a single file)

**Lesson steps**

1. Merge three files into tab columns (`paste`)
2. Join fields with a colon delimiter (`paste -d`)
3. Turn one file into one line with -s (`paste -s`)

**Files**

| File | Role |
| --- | --- |
| [`pack_columns.zsh`](pack_columns.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/carton-colors.txt`](fixtures/carton-colors.txt) | Fixture copied into the script's temp folder |
| [`fixtures/carton-ids.txt`](fixtures/carton-ids.txt) | Fixture copied into the script's temp folder |
| [`fixtures/carton-sizes.txt`](fixtures/carton-sizes.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/06-dhaka-garment-packing/pack_columns.zsh
tests/run-examples.zsh 06-dhaka-garment-packing
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
