# Searching text with grep · 07 · Yangon family, comparing two mohinga recipes

Two relatives in Yangon keep mohinga recipes: Aunt Thida's for twelve, Cousin Htet's small batch. Context flags pull the toppings under a heading, the lines around banana stem, and the fish-sauce note in both files.

**What it teaches**

- `grep -A N` prints N lines after each match; `-B N` prints N before; `-C N` is both
- context lines are marked with `-` instead of `:`; a `--` group separator sits between hits
- `-A`/`-B`/`-C` work with `-n` and with multiple files (`file:line:` on the match)
- useful when the interesting bit is the paragraph around a heading, not the heading alone

**Lesson steps**

1. Print lines after a match with -A (`grep -A`)
2. Print lines before a match with -B (`grep -B`)
3. Print context on both sides with -C (`grep -C`)
4. Combine -n with -A (`grep -nA`)

**Files**

| File | Role |
| --- | --- |
| [`compare_recipes.zsh`](compare_recipes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/aunt-thida.txt`](fixtures/aunt-thida.txt) | Fixture copied into the script's temp folder |
| [`fixtures/cousin-htet.txt`](fixtures/cousin-htet.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/07-yangon-mohinga-recipes/compare_recipes.zsh
tests/run-examples.zsh 07-yangon-mohinga-recipes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
