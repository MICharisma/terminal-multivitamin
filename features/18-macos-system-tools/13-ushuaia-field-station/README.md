# macOS system tools · 13 · Ushuaia field station night kit

A climate field station outside Ushuaia packs a night kit: throwaway defaults for the logger id, a one-second caffeinate window while a sample file is stamped, and `mdls` on that sample. Capstone combining the feature's tools safely.

**What it teaches**

- `defaults write` records the logger id in a throwaway domain, deleted in the trap
- `caffeinate -t 1` covers the stamp step
- `mdls -name kMDItemFSName` confirms the sample on disk

**Lesson steps**

1. Record the logger id with defaults write (`defaults write`)
2. Hold sleep for the stamp second (`caffeinate -t`)
3. Confirm the sample with mdls (`mdls`)

**Files**

| File | Role |
| --- | --- |
| [`night_kit.zsh`](night_kit.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/13-ushuaia-field-station/night_kit.zsh
tests/run-examples.zsh 13-ushuaia-field-station
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
