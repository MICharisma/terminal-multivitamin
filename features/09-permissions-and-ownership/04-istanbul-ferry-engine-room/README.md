# Permissions and ownership · 04 · Istanbul ferry engine room, the check script that will not run

The engineer on a Kadıköy–Karaköy ferry in Istanbul runs two small check scripts before the first crossing. One was saved without its execute bit, one was last edited on the office's Windows laptop, and later the folder itself loses its `x` bit. Each attempt goes through one small `try` function that reads the exit status, so you can tell 126 ("found, not executable") from 127 ("not found, or its interpreter is not") and fix the right thing.

**What it teaches**

- without the `x` bit, `./bilge_check.sh` fails with exit status 126 (found, not executable)
- `sh bilge_check.sh` runs it anyway: the interpreter only needs to read the file
- a bare `bilge_check.sh` is 127 (not found): the current folder is not on `PATH`
- `chmod u+x` fixes it; a `#!` line with a Windows `\r` gives 127 "bad interpreter"
- every folder on the way needs `x` too: without it the script is 126 again

**Lesson steps**

1. Run the check without an x bit (`exit status 126`)
2. Run it through sh instead (`sh script`)
3. Call it without ./ (`exit status 127`)
4. Add the owner's execute bit (`chmod u+x`)
5. Fix the Windows line ending in the #! line (`#! line`)
6. Take x away from the folder on the way (`folder x bit`)

**Files**

| File | Role |
| --- | --- |
| [`run_checks.zsh`](run_checks.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/04-istanbul-ferry-engine-room/run_checks.zsh
tests/run-examples.zsh 04-istanbul-ferry-engine-room
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
