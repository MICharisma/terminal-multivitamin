# ssh, scp, and rsync · 09 · Dhaka payments jumpbox mux

A payments lab in Dhaka multiplexes SSH to `paylab.dhaka.internal` so deploy
sessions share one TCP connection. The script writes `ControlMaster`,
`ControlPath`, and `ControlPersist` into a throwaway config and resolves them
with `ssh -G` — no live mux needed.

**What it teaches**

- `ControlMaster auto` reuses one SSH connection for later sessions
- `ControlPath` names the mux socket (keep it in the workdir)
- `ControlPersist` keeps the master alive after the first client exits

**Lesson steps**

1. Write a paylab Host block with ControlMaster auto (`ControlMaster`)
2. Resolve ControlMaster for the jumpbox alias (`ControlMaster`)
3. Show the ControlPath socket basename under mux/ (`ControlPath`)
4. Confirm ControlPersist keeps the master around (`ControlPersist`)

**Files**

| File | Role |
| --- | --- |
| [`mux_jumpbox.zsh`](mux_jumpbox.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/09-dhaka-mux-jumpbox/mux_jumpbox.zsh
tests/run-examples.zsh 09-dhaka-mux-jumpbox
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
