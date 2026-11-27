# Searching text with grep · 02 · Porto wine lodge, finding bottles in the inventory

A Port wine lodge in Vila Nova de Gaia keeps a bin inventory of Tawny, Vintage and Ruby bottles. Case-insensitive search finds every Tawny; whole-word search distinguishes `Ruby` from the letters `Rub` that sit inside other words.

**What it teaches**

- `grep -i` ignores case: `tawny` matches `Tawny` and `TAWNY`
- `grep -w` matches a whole word: `Ruby` matches, `Rub` does not
- `-i` and `-w` combine; the pattern can still use basic regex
- note: GNU grep treats `-` as a word boundary, so `-w 20` *does* match inside `20-year`

**Lesson steps**

1. Match Tawny in any capitalisation (`grep -i`)
2. Match a whole word only (`grep -w`)
3. Combine -i and -w to count Tawny lines (`grep -iw`)

**Files**

| File | Role |
| --- | --- |
| [`lodge_inventory.zsh`](lodge_inventory.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/02-porto-wine-lodge/lodge_inventory.zsh
tests/run-examples.zsh 02-porto-wine-lodge
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
