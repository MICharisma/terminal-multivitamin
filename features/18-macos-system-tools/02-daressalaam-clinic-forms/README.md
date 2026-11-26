# macOS system tools · 02 · Dar es Salaam clinic forms, reading Spotlight metadata

A community clinic in Dar es Salaam keeps intake forms as text files on a shared Mac mini. Before filing, the clerk reads `kMDItemFSName` and `kMDItemFSSize` with `mdls -name` for each form — no Spotlight query required.

**What it teaches**

- `for form in intake/*.txt` walks every form once
- `mdls -name kMDItemFSName -name kMDItemFSSize` prints selected attributes
- relative names stay in the ledger; absolute temp paths never do

**Lesson steps**

1. Loop over each intake form (`for f in glob`)
2. Read FS name and size with mdls -name (`mdls -name`)

**Files**

| File | Role |
| --- | --- |
| [`form_metadata.zsh`](form_metadata.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/02-daressalaam-clinic-forms/form_metadata.zsh
tests/run-examples.zsh 02-daressalaam-clinic-forms
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
