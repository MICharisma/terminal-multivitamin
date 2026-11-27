# ssh, scp, and rsync · 03 · Porto family photos to grandmother's inbox

A neto in Porto copies `fotos-douro/barco-rabelo.jpg` into his avó's inbox. The
script spins up a throwaway local `sshd`, uses `scp` once, and keeps the host key
in a workdir `known_hosts` via `StrictHostKeyChecking` and `UserKnownHostsFile`.

**What it teaches**

- `scp` copies one file to a remote path over SSH
- `StrictHostKeyChecking accept-new` records the host key on first connect
- `UserKnownHostsFile` keeps that record inside the workdir, not `~/.ssh`

**Lesson steps**

1. Show grandmother's inbox before the transfer (`scp`)
2. scp the Douro barco photo into the inbox over local sshd (`scp`)
3. Record the host key with StrictHostKeyChecking accept-new (`StrictHostKeyChecking`)
4. Keep the known_hosts file inside the workdir (`UserKnownHostsFile`)
5. List the inbox after the photo arrives (`scp`)

**Files**

| File | Role |
| --- | --- |
| [`send_album.zsh`](send_album.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/fotos-douro/`](fixtures/fotos-douro/) | The family album file copied into the sandbox |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/03-porto-family-photos/send_album.zsh
tests/run-examples.zsh 03-porto-family-photos
```

The script creates its own folder with `mktemp -d`, works only inside it, kills the local `sshd` on exit, and deletes the workdir. It runs the same on macOS and Linux.
