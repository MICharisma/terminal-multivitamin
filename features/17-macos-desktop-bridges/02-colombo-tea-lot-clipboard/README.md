# macOS desktop bridges · 02 · Colombo tea auction clipboard for the lot board

At the Ceylon Tea Brokers floor in Colombo, a clerk builds each lot line in Terminal and needs it on the pasteboard for the auctioneer's board app. `pbcopy` takes the line, `pbpaste` drops it into `lot-board.txt`, and a second copy replaces the first.

**What it teaches**

- `print -n ... | pbcopy` puts text on the macOS pasteboard
- `pbpaste` reads it back; redirect into a board file for the auctioneer
- a second copy replaces the first; the pasteboard holds one thing at a time

**Lesson steps**

1. Copy this morning's Uva lot onto the pasteboard (`pbcopy`)
2. Paste it into the auctioneer's board file (`pbpaste`)
3. Replace the pasteboard with the next Nuwara Eliya lot (`pbcopy`)

**Files**

| File | Role |
| --- | --- |
| [`lot_clipboard.zsh`](lot_clipboard.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/02-colombo-tea-lot-clipboard/lot_clipboard.zsh
tests/run-examples.zsh 02-colombo-tea-lot-clipboard
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
