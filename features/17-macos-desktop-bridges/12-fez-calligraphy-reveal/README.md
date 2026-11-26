# macOS desktop bridges · 12 · Fez calligraphy studio, revealing a folio

A calligraphy studio in Fez prepares a folio for a client Zoom. `open -R` would reveal the folio in Finder; `osascript --` receives the folio name as argv and returns a short caption — both guarded or non-GUI so CI stays quiet.

**What it teaches**

- `open -R` reveals a file in a Finder window (guarded when headless)
- `osascript --` passes shell argv into `on run argv`
- AppleScript returns a caption string the studio pastes into the call notes

**Lesson steps**

1. Reveal the folio in Finder (`open -R`)
2. Pass the folio name into osascript as argv (`osascript --`)

**Files**

| File | Role |
| --- | --- |
| [`reveal_folio.zsh`](reveal_folio.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/12-fez-calligraphy-reveal/reveal_folio.zsh
tests/run-examples.zsh 12-fez-calligraphy-reveal
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
