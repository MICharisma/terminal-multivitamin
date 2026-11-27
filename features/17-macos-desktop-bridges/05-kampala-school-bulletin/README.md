# macOS desktop bridges · 05 · Kampala school bulletin via AppleScript

Nakasero Primary's office in Kampala assembles the Friday bulletin title from class names. A small function with `emulate -L zsh` calls `osascript -e` to join the list in AppleScript and return one line — no GUI automation, just string work.

**What it teaches**

- `emulate -L zsh` plus `setopt local_options` keeps the helper's options local
- `osascript -e` runs a one-liner that joins class names with commas
- the function returns AppleScript's result into a shell variable

**Lesson steps**

1. Localize options inside the bulletin helper (`emulate -L zsh`)
2. Join class names with osascript -e (`osascript -e`)

**Files**

| File | Role |
| --- | --- |
| [`bulletin_title.zsh`](bulletin_title.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/05-kampala-school-bulletin/bulletin_title.zsh
tests/run-examples.zsh 05-kampala-school-bulletin
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
