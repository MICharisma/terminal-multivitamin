# macOS desktop bridges · 09 · Sapporo miso brewery label formats

A family miso brewery near Sapporo ships jar labels as PNG and needs JPEG proofs for the printer. The script copies the master, records the format with `sips -g`, converts with `sips -s format jpeg`, then compares before and after.

**What it teaches**

- `sips -g format` reads the image format keyword
- `sips -s format jpeg` writes a JPEG proof beside the PNG master
- a before/after pair makes the conversion obvious in the ledger

**Lesson steps**

1. Read the master label's format (`sips -g`)
2. Convert a copy to JPEG for the printer (`sips -s format`)

**Files**

| File | Role |
| --- | --- |
| [`label_formats.zsh`](label_formats.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/aka-miso-label.png`](fixtures/aka-miso-label.png) | Master PNG label copied into the sandbox |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/09-sapporo-miso-labels/label_formats.zsh
tests/run-examples.zsh 09-sapporo-miso-labels
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
