# Permissions and ownership · 10 · Cape Town sea rescue station, handing files to the station account

A volunteer at the sea rescue station in Hout Bay, near Cape Town, is handing November's launch logs and the crew roster over to the shared station account. Some of that a regular user may do (`chown` to yourself, `chgrp` to your own group), and some only root may do (give a file to another user or to a group you are not in). The script makes the allowed changes, shows the refused ones failing with "Operation not permitted", and writes the rest into a quoted `sudo` plan for the station commander to review, without ever calling `sudo` itself.

**What it teaches**

- `ls -n` shows the owner and group as numbers; compare them with `id -u` and `id -G`
- you may `chgrp` your own file to a group you belong to, and `chown` it to yourself
- giving a file to another user, or to a group you are not in, needs root: "Operation not permitted"
- only the owner may `chmod` a file, and `[[ -O f ]]` tests that without trying
- collect the commands that need `sudo` into a plan, quote them with `${(q-)...}`, and let a person review and run them; the script itself never calls `sudo`

**Lesson steps**

1. Read the owner and group as numbers (`ls -n`)
2. Make the changes a regular user may make (`chgrp`)
3. Try to give a file away, and get refused (`chown`)
4. Test ownership instead of trying (`[[ -O ]]`)
5. Write the root-only commands into a plan for review (`sudo`)

**Files**

| File | Role |
| --- | --- |
| [`handover_plan.zsh`](handover_plan.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/10-cape-town-rescue-handover/handover_plan.zsh
tests/run-examples.zsh 10-cape-town-rescue-handover
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
