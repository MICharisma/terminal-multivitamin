# macOS desktop bridges · 11 · Cluj-Napoca deploy notes on the pasteboard

A small platform co-op in Cluj-Napoca pastes release notes into Slack from Terminal. Process substitution builds the notes file, then `pbcopy < <(...)` or piping from the process substitution loads the pasteboard in one step.

**What it teaches**

- process substitution `<(...)` exposes a command's output as a file
- `pbcopy < <(print ...)` loads the pasteboard without a leftover notes file
- `pbpaste` confirms the deploy summary before anyone hits paste in Slack

**Lesson steps**

1. Build release notes through process substitution (`process substitution`)
2. Load the pasteboard from that stream (`pbcopy`)
3. Confirm with pbpaste before Slack (`pbpaste`)

**Files**

| File | Role |
| --- | --- |
| [`deploy_notes.zsh`](deploy_notes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/11-cluj-deploy-notes/deploy_notes.zsh
tests/run-examples.zsh 11-cluj-deploy-notes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
