# ssh, scp, and rsync · 05 · Cape Town Baxter Theatre rehearsal sync

Stage management at the Baxter Theatre archives act-1 rehearsal takes into
`archive/week-47/`. One `rsync -av` pipeline mirrors the folder locally — no SSH
needed — and the script prints a quiet summary plus the archive listing.

**What it teaches**

- `rsync -av` mirrors a folder tree while keeping permissions and times
- a trailing slash on the source copies the *contents* into the destination

**Lesson steps**

1. List this week's act-1 rehearsal takes (`rsync -av`)
2. rsync -av the takes into archive/week-47 (`rsync -av`)
3. Confirm the archive week holds both cue sheets (`rsync -av`)

**Files**

| File | Role |
| --- | --- |
| [`archive_rehearsal.zsh`](archive_rehearsal.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/rehearsal/act-1/`](fixtures/rehearsal/act-1/) | Cue sheets for the Madiba entrance and bridge chorus |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/05-cape-town-rehearsal-sync/archive_rehearsal.zsh
tests/run-examples.zsh 05-cape-town-rehearsal-sync
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
