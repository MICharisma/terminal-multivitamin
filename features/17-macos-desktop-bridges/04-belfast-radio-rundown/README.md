# macOS desktop bridges · 04 · Belfast radio rundown, converting the cue sheet

Downtown Radio's evening desk in Belfast keeps cue sheets as plain text next to RTF copies for the on-air laptop. A plan file lists each convert; `textutil -convert` turns txt into rtf while a `while read` walks the plan.

**What it teaches**

- `while read -r src dest` splits a two-column convert plan on IFS whitespace
- `textutil -convert rtf -output ...` writes an RTF the on-air Mac can open
- the plan keeps source and destination names explicit, no guessing extensions

**Lesson steps**

1. Read each convert line from the plan (`while read -r`)
2. Convert the cue sheet to RTF (`textutil -convert`)

**Files**

| File | Role |
| --- | --- |
| [`convert_rundown.zsh`](convert_rundown.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/04-belfast-radio-rundown/convert_rundown.zsh
tests/run-examples.zsh 04-belfast-radio-rundown
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
