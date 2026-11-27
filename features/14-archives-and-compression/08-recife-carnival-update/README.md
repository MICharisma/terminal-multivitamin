# Archives and compression · 08 · Recife carnival office update

The carnival office near the Marco Zero keeps route and float notes in one zip.
After the tide advisory, a `while read` plan drives `zip -u` so only the changed
members refresh.

**What it teaches**

- `zip` adds the first wave of office files to a new archive
- a `while read` plan feeds `zip -u`, which refreshes only the changed members

**Lesson steps**

1. Seed the carnival desk zip with the first wave of files (`zip`)
2. Read the refresh plan and zip -u each changed member (`zip -u`)
3. Print the updated route and float notes from the zip (`zip -u`)

**Files**

| File | Role |
| --- | --- |
| [`update_archive.zsh`](update_archive.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/14-archives-and-compression/08-recife-carnival-update/update_archive.zsh
tests/run-examples.zsh 08-recife-carnival-update
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
