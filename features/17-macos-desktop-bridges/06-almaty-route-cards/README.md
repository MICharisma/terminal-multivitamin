# macOS desktop bridges · 06 · Almaty climbing club route cards

The Almaty Alpine Club keeps route cards as PDFs, GPX tracks, and HTML topos. A `case` on the extension picks `open -a Preview` or a `file://` URL — guarded so CI only prints the would-be command with a relative path.

**What it teaches**

- `case ${card:e} in` routes each card by extension
- `open -a Preview` targets a specific app instead of the default
- `open file://...` opens a local HTML topo in the default browser

**Lesson steps**

1. Route each card by its extension (`case`)
2. Open a PDF in Preview by name (`open -a`)
3. Open a local HTML topo via file:// (`open file://`)

**Files**

| File | Role |
| --- | --- |
| [`open_routes.zsh`](open_routes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/06-almaty-route-cards/open_routes.zsh
tests/run-examples.zsh 06-almaty-route-cards
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
