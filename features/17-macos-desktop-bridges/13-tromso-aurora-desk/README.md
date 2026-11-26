# macOS desktop bridges · 13 · Tromsø aurora desk, bridging a night's report

The aurora desk at a Tromsø geophysics lab finishes the night by converting a plain report to HTML, copying a one-line alert to the pasteboard, and opening the HTML card — a small dispatch table picks each bridge. Capstone for the feature.

**What it teaches**

- an associative dispatch table maps action names to bridge tools
- `textutil -convert` builds the HTML night card from the plain report
- `pbcopy` then a guarded `open` finish the handoff to the morning shift

**Lesson steps**

1. Convert the night report to HTML (`textutil -convert`)
2. Copy the alert line to the pasteboard (`pbcopy`)
3. Open the HTML card for the morning shift (`open`)

**Files**

| File | Role |
| --- | --- |
| [`aurora_desk.zsh`](aurora_desk.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/13-tromso-aurora-desk/aurora_desk.zsh
tests/run-examples.zsh 13-tromso-aurora-desk
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
