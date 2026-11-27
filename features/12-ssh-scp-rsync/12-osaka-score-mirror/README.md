# ssh, scp, and rsync · 12 · Osaka score library mirror

The Kansai Philharmonic librarian keeps a working mirror of the sheet-music
library. After a draft is withdrawn from `current/`, `rsync --delete -av`
removes the stale copy from the mirror so both trees match.

**What it teaches**

- `rsync --delete -av` makes the destination match the source, removing extras
- a before/after listing shows which stale score disappeared

**Lesson steps**

1. List the mirror while it still holds a withdrawn draft (`rsync --delete`)
2. rsync --delete so the mirror matches the current library (`rsync --delete`)
3. Confirm old-draft.ly is gone and the current scores remain (`rsync --delete`)

**Files**

| File | Role |
| --- | --- |
| [`mirror_scores.zsh`](mirror_scores.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/library/current/`](fixtures/library/current/) | The live score tree |
| [`fixtures/library/stale-copy/`](fixtures/library/stale-copy/) | An older mirror that still has a withdrawn draft |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/12-osaka-score-mirror/mirror_scores.zsh
tests/run-examples.zsh 12-osaka-score-mirror
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
