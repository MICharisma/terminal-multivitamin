# Editing streams with sed and awk · 03 · Quito orchid nursery export

A nursery above Tumbaco exports orchids with a status word on each line: `shipped`, `ready`, or `draft`. Customs wants the first three rows; finance needs drafts removed; the truck dispatcher wants everything not yet shipped. Quiet printing, delete, invert, and an early quit each slice the same export differently.

**What it teaches**

- `sed -n 'p'` prints only the lines that survive earlier commands in the script
- `sed '/pattern/d'` deletes matching lines from the stream
- `sed '/pattern/!p'` inverts the match so non-matching lines print
- `sed 'Nq'` quits after line N, handy for a quick header peek

**Lesson steps**

1. Show only the first three lines (`sed -n '1,3p'`)
2. Drop draft lots with `d` (`sed '/pattern/d'`)
3. Print lines that do not match `shipped` (`sed -n '/pattern/!p'`)
4. Stop after line five (`sed -n '5{p;q;}'`)

**Files**

| File | Role |
| --- | --- |
| [`orchid_export.zsh`](orchid_export.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/nursery-export.txt`](fixtures/nursery-export.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/03-quito-orchid-nursery/orchid_export.zsh
tests/run-examples.zsh 03-quito-orchid-nursery
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
