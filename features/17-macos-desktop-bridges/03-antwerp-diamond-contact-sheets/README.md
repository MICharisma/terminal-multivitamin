# macOS desktop bridges · 03 · Antwerp diamond atelier contact sheets

A polishing atelier on Antwerp's Hoveniersstraat keeps microscope stills of each stone. Before the buyer walkthrough they need every still scaled to a 64-pixel contact tile; `sips -Z` resizes copies, and `sips -g` reads the new width.

**What it teaches**

- `for stone in stones/*.png` walks every still once
- `sips -Z 64` fits the long side to 64 pixels into a contact sheet copy
- `sips -g pixelWidth` reads the width so the ledger can record it

**Lesson steps**

1. Loop over every stone still (`for f in glob`)
2. Fit each copy to a 64-pixel contact tile (`sips -Z`)
3. Read the new pixel width into the ledger (`sips -g`)

**Files**

| File | Role |
| --- | --- |
| [`contact_sheets.zsh`](contact_sheets.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Source stone PNGs copied into the sandbox |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/03-antwerp-diamond-contact-sheets/contact_sheets.zsh
tests/run-examples.zsh 03-antwerp-diamond-contact-sheets
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
