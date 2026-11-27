# Sorting, counting, and columns · 10 · Porto wine lodge, measuring the tasting notes sheet

Gaia tasting room staff keep short notes for each barrel sample. Before printing back labels they need line, word, and byte counts, plus the longest note. `wc` reports them in one pass, `wc -L` finds the longest line, and wrapping counts in `$(( $(wc -l < f) ))` avoids BSD padding in the printed field.

**What it teaches**

- `wc -l`, `wc -w`, and `wc -c` count lines, words, and bytes in one pass
- `wc -L` reports the longest line length (GNU and BSD, with different padding on counts)
- reading `wc -l` through arithmetic `$(($(wc -l < f)))` drops BSD's leading spaces

**Lesson steps**

1. Count lines, words, and bytes on the sheet (`wc -l -w -c`)
2. Find the longest line with wc -L (`wc -L`)
3. Compare raw wc -l with arithmetic stripping (`wc -l <`)

**Files**

| File | Role |
| --- | --- |
| [`lodge_counts.zsh`](lodge_counts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/tasting-notes.txt`](fixtures/tasting-notes.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/10-porto-wine-lodge/lodge_counts.zsh
tests/run-examples.zsh 10-porto-wine-lodge
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
