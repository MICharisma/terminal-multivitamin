# Navigation and files · 12 · Helsinki music academy practice-room cleanup

Practice rooms at a Helsinki music academy record to month folders. Cleaning them up has three traps: a recorder app saved a take as `-take3.wav`, some month folders are empty and some are not, and a cleanup function must never run `rm -r` on an empty path. The script walks through each trap without losing Eero's good kantele take.

**What it teaches**

- `${var:?message}` stops the script before `rm -r` can run on an empty path
- `mv --` and `rm --` handle a file whose name starts with a dash
- `rmdir` removes only empty folders, so it is a safe sweep after moving files
- `rm -f` is quiet about files that are already gone

**Lesson steps**

1. Remove a file whose name starts with a dash (`rm --`)
2. Sweep away only the empty month folders (`rmdir`)
3. Refuse to rm -r an empty path (`${var:?}`)
4. Remove quietly whether or not the file exists (`rm -f`)

**Files**

| File | Role |
| --- | --- |
| [`clear_recordings.zsh`](clear_recordings.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/12-helsinki-practice-rooms/clear_recordings.zsh
tests/run-examples.zsh 12-helsinki-practice-rooms
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
