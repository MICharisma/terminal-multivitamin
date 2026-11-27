# Permissions and ownership · 11 · Gdańsk shipyard welding cell, installing robot tools in portable sh

The welding cell at a Gdańsk shipyard runs two calibration scripts on its robot controller, plus a config file for hull block B-214 and a service PIN that only the cell engineer should read. The controller's shell is a plain POSIX `sh`, so the installer is too: a here-doc manifest lists mode, kind, source and destination, and `install -m` / `install -d -m` set every mode exactly as they copy. A final comparison with `cp` shows why: a copy keeps whatever mode its source happened to have.

**What it teaches**

- `install -m 0755 src dest` copies and sets the mode in one step: no moment where a config file sits on disk with the wrong mode, as it would between `cp` and `chmod`
- `install -d -m 0750 dir` creates a folder with an exact mode, whatever the umask
- `cp` keeps the source's mode (minus the umask), so a 600 secret copied with `cp` stays 600, but a 644 draft stays 644 where 640 was wanted
- a here-doc manifest read with `while read -r mode kind src dest` keeps the plan in one place
- `ls -ld path | cut -c1-10` reads a mode string the same way on macOS and Linux

**Lesson steps**

1. Read the install plan from a here-doc manifest (`while read -r`)
2. Create folders with exact modes (`install -d -m`)
3. Copy files and set their modes in one step (`install -m`)
4. Run the installed tools (`install -m`)
5. Compare with cp, which keeps the source mode (`cp`)

**Files**

| File | Role |
| --- | --- |
| [`install_tools.sh`](install_tools.sh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/11-gdansk-welding-robot-tools/install_tools.sh
tests/run-examples.zsh 11-gdansk-welding-robot-tools
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (any POSIX `sh`).
