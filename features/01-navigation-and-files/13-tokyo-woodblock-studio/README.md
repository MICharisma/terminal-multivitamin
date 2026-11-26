# Navigation and files · 13 · Tokyo woodblock print studio, tidying before a client call

A mokuhanga (woodblock print) studio in Tokyo is about to share its screen with a client. The proofs folder should vanish from Finder without being renamed, and the final print should carry the printer's name as metadata. `chflags hidden` and `xattr` are macOS tools, so this is the one example the Linux test job skips.

**What it teaches**

- `chflags hidden` hides a folder from Finder without renaming it; `ls -lO` shows the flag
- Terminal still sees hidden folders: `ls` lists them, `cd` enters them
- `xattr -w` / `-p` / `-d` attach, read, and remove extended attributes on a file
- `cp` keeps extended attributes on macOS; `cp -X` leaves them behind

**Lesson steps**

1. Hide the proofs folder from Finder (`chflags hidden`)
2. Terminal still lists and enters the hidden folder (`ls`)
3. Record the printer as an extended attribute (`xattr -w`)
4. Copy with and without extended attributes (`cp -X`)
5. Remove the attribute and unhide the folder (`chflags nohidden`)

**Files**

| File | Role |
| --- | --- |
| [`hide_proofs.zsh`](hide_proofs.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/13-tokyo-woodblock-studio/hide_proofs.zsh
tests/run-examples.zsh 13-tokyo-woodblock-studio
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS (`chflags` and `xattr`); on Linux it prints a message and exits 2, and the test runner skips it.
