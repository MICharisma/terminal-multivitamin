# macOS system tools · 06 · Cartagena library disk check

The rare-books Mac at a Cartagena public library needs a quick read-only look at the boot volume before a digitizing day. `diskutil info /` is filtered through a `case` so only the stable Mount Point field prints.

**What it teaches**

- `diskutil info /` reads the boot volume (never erase, never partition)
- a `case` on the field name keeps only Mount Point
- values are replaced with `present` so machines compare equal

**Lesson steps**

1. Read boot volume info (`diskutil info`)
2. Keep only stable field names (`case`)

**Files**

| File | Role |
| --- | --- |
| [`disk_check.zsh`](disk_check.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/06-cartagena-disk-check/disk_check.zsh
tests/run-examples.zsh 06-cartagena-disk-check
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
