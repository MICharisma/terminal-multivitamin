# Sorting, counting, and columns · 03 · Turin classic car workshop, cutting columns from a parts catalogue

An Officina Bertone-Rossi in Turin restores Fiat 500s, Lancia Fulvias and Alfa Romeo Giulias, and the supplier still sends a fixed-width printout of the parts catalogue. Work orders are a TSV the front desk keeps. `cut -c` pulls codes and prices from the printout, `cut -f` pulls the mechanic from each order, and both have traps: spaces are not a field separator, and `-f4,2` does not reorder the columns.

**What it teaches**

- `cut -c1-8` and `cut -c48-` take character columns, the right tool for a fixed-width printout
- `cut -d' '` treats every single space as a separator, so padded columns come out empty
- `cut -f` splits on tabs by default; `-s` drops lines with no tab, such as a comment header
- `cut` always prints fields in file order: `-f4,2` is the same as `-f2,4`
- `-f1,3-` keeps every field but the second; GNU's `--complement -f2` is not in BSD `cut`

**Lesson steps**

1. Cut character columns from the fixed-width catalogue (`cut -c`)
2. See cut -d' ' treat every pad space as a field (`cut -d`)
3. Cut tab fields and drop the comment with -s (`cut -f -s`)
4. See that cut never reorders fields (`cut -f`)
5. Keep every field but the part code with 1,3- (`cut -f1,3-`)

**Files**

| File | Role |
| --- | --- |
| [`parts_columns.zsh`](parts_columns.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/catalogo-ricambi.txt`](fixtures/catalogo-ricambi.txt) | Fixture copied into the script's temp folder |
| [`fixtures/work-orders.tsv`](fixtures/work-orders.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/03-turin-restoration-parts/parts_columns.zsh
tests/run-examples.zsh 03-turin-restoration-parts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
