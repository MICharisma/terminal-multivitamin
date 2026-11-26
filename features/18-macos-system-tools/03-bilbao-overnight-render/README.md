# macOS system tools · 03 · Bilbao overnight render under caffeinate

An animation desk in Bilbao kicks off a short overnight frame dump and needs the Mac to stay awake for the duration. `caffeinate -t 2` holds idle sleep for two seconds around a stand-in render function.

**What it teaches**

- `emulate -L zsh` keeps the render helper's options local
- `caffeinate -t 2` asserts user idle sleep for two seconds
- the render stand-in runs under that assertion and writes one frame mark

**Lesson steps**

1. Localize the render helper (`emulate -L zsh`)
2. Hold idle sleep for two seconds (`caffeinate -t`)

**Files**

| File | Role |
| --- | --- |
| [`overnight_render.zsh`](overnight_render.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/03-bilbao-overnight-render/overnight_render.zsh
tests/run-examples.zsh 03-bilbao-overnight-render
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
