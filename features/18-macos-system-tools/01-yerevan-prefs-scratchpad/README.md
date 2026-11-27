# macOS system tools · 01 · Yerevan prefs scratchpad for a workshop app

A weekend Swift workshop in Yerevan needs a throwaway defaults domain while students experiment. The script writes `com.micharisma.multivitamin.yerevan-workshop`, reads a key back, then deletes the domain in the trap so nothing lingers in the sandbox HOME.

**What it teaches**

- `defaults write domain key -string` sets a preference in a throwaway domain
- `defaults read domain key` prints it back for the projector
- `defaults delete domain` in the EXIT trap removes every key we created

**Lesson steps**

1. Write the workshop cohort into a throwaway domain (`defaults write`)
2. Read the cohort back for the projector (`defaults read`)
3. Delete the domain on the way out (`defaults delete`)

**Files**

| File | Role |
| --- | --- |
| [`prefs_scratchpad.zsh`](prefs_scratchpad.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/01-yerevan-prefs-scratchpad/prefs_scratchpad.zsh
tests/run-examples.zsh 01-yerevan-prefs-scratchpad
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
