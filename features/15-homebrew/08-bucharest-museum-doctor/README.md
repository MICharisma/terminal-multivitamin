# Homebrew · 08 · Bucharest museum digitization doctor

The National History Museum of Romania's digitization NGO in Bucharest checks the scan-room Mac with `brew doctor` each quarter. Warnings are filtered via process substitution for standup; repairs are a separate ticket.

**What it teaches**

- `brew doctor` prints diagnostics; a healthy prefix still exits 0 with "ready to brew"
- process substitution `<( )` feeds the doctor log into `grep` without a temp file
- the museum run is read-only: warnings are listed, nothing is repaired here

**Lesson steps**

1. Run brew doctor and capture its log (`brew doctor`)
2. Filter warnings with process substitution (`brew doctor`)

**Files**

| File | Role |
| --- | --- |
| [`doctor_filter.zsh`](doctor_filter.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew doctor` output |

**Try it**

From the repository root:

```sh
features/15-homebrew/08-bucharest-museum-doctor/doctor_filter.zsh
tests/run-examples.zsh 08-bucharest-museum-doctor
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
