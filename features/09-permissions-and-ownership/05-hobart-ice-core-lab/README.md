# Permissions and ownership · 05 · Hobart Antarctic research lab, choosing a umask for ice core data

An ice core lab in Hobart, Tasmania, stores measurements from the Law Dome drilling site. Outreach images can be public, most data is for the project group, and some is embargoed until a paper comes out. The script tries three umasks, each in its own subshell, predicts the resulting modes with octal arithmetic before creating anything, and then shows the two things a umask cannot do: override `mkdir -m` or `chmod`, and add an execute bit.

**What it teaches**

- `umask` removes bits from new files (which start at 666) and new folders (777)
- `$(( 8#666 & ~8#027 ))` predicts the mode; `printf %03o` prints it as octal
- `umask -S` shows the same mask as the bits that are *kept*: `u=rwx,g=rx,o=`
- a `( subshell )` scopes a umask change to one block
- a umask only takes bits away; `mkdir -m` and `chmod` afterwards still set what they say

**Lesson steps**

1. List the masks the lab is choosing between (`umask`)
2. Predict each mode, then create a core folder in a subshell (`umask 027`)
3. Read the same mask as the bits that are kept (`umask -S`)
4. Check that the subshells left the script's umask alone (`umask in a subshell`)
5. See that a umask only takes bits away (`mkdir -m`)

**Files**

| File | Role |
| --- | --- |
| [`umask_table.zsh`](umask_table.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/05-hobart-ice-core-lab/umask_table.zsh
tests/run-examples.zsh 05-hobart-ice-core-lab
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
