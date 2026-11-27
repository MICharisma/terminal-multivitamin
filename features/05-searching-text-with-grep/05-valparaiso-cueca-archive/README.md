# Searching text with grep · 05 · Valparaíso cueca archive, indexing the verses

A folk archive in Valparaíso indexes cueca verses for a binder. `-n` prints line numbers, `-o` prints only the matching phrase, and together they pull every `pañuelo` and `cueca` out of the page.

**What it teaches**

- `grep -n` prefixes each match with its line number; add `-i` to ignore case: `5:Cueca brava...`
- `grep -o` prints only the matching part, not the whole line (one match per line by default)
- `-o` with `-n` still shows the line number of each match piece
- `-E` plus `-o` pulls every `pañuelo` out of a line that holds two

**Lesson steps**

1. Number the matching verses (`grep -n`)
2. Print only the matching phrase (`grep -o`)
3. Number each matching piece (`grep -no`)
4. Pull every match on a line with -Eo (`grep -Eo`)

**Files**

| File | Role |
| --- | --- |
| [`verse_index.zsh`](verse_index.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/verses.txt`](fixtures/verses.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/05-valparaiso-cueca-archive/verse_index.zsh
tests/run-examples.zsh 05-valparaiso-cueca-archive
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
