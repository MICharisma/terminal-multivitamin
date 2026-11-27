# Editing streams with sed and awk · 04 · Antwerp diamond inventory

Stones on Hoveniersstraat arrive with GIA, HRD, or IGI certificate prefixes baked into the scanner export. The vault ledger wants a uniform `stock GIA` line, HRD lines that keep the lab number, and IGI lines that mention the cut code. Capture groups, `&`, and a `case` router apply a different `sed` to each format.

**What it teaches**

- `sed` capture groups use `\(...\)` and refer back with `\1` in the replacement
- `&` in the replacement inserts the whole matched text
- grouping rewrite rules in a `case` router keeps each certificate format separate

**Lesson steps**

1. Rewrite GIA numbers with capture groups (`sed 's/\(a\)\(b\)/x \2/'`)
2. Keep the HRD prefix with `&` (`sed 's/pattern/& suffix/'`)
3. Route each certificate format through `case` (`case $line in`)

**Files**

| File | Role |
| --- | --- |
| [`diamond_tags.zsh`](diamond_tags.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/inventory.tsv`](fixtures/inventory.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/04-antwerp-diamond-inventory/diamond_tags.zsh
tests/run-examples.zsh 04-antwerp-diamond-inventory
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
