# macOS desktop bridges · 08 · Valletta maritime museum wall-label captures

Heritage Malta's maritime museum in Valletta stages wall labels before a gallery opens. A capture plan lists window flags; the script builds `screencapture` argv and, under the headless guard, only prints what would run — no screen-recording prompt on CI.

**What it teaches**

- an array of capture specs drives the shot list
- `screencapture -x -o` would save silently without shutter sound or shadow
- headless mode prints the full command instead of touching the display

**Lesson steps**

1. Build each capture from the shot list (`screencapture`)
2. Print the guarded command instead of prompting (`headless guard`)

**Files**

| File | Role |
| --- | --- |
| [`label_captures.zsh`](label_captures.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/08-valletta-wall-labels/label_captures.zsh
tests/run-examples.zsh 08-valletta-wall-labels
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
