# ssh, scp, and rsync · 08 · Edinburgh fintech desk agent keys

A fintech desk in Leith loads the production deploy key into `ssh-agent` for the
shift. The script starts the agent in a subshell capture, `ssh-add`s the key,
lists it with `ssh-add -l` (printing only the comment), and the parent trap kills
the agent on exit.

**What it teaches**

- `ssh-agent` holds decrypted keys in memory for a session
- `ssh-add` loads a private key into that agent
- `ssh-add -l` lists the loaded keys (here: only the comment)

**Lesson steps**

1. Start ssh-agent and keep its socket for the desk session (`ssh-agent`)
2. ssh-add the production deploy key into the agent (`ssh-add`)
3. List loaded keys with ssh-add -l (comments only) (`ssh-add -l`)

**Files**

| File | Role |
| --- | --- |
| [`load_deploy_key.zsh`](load_deploy_key.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/08-edinburgh-agent-keys/load_deploy_key.zsh
tests/run-examples.zsh 08-edinburgh-agent-keys
```

The script creates its own folder with `mktemp -d`, works only inside it, kills `ssh-agent` on exit, and deletes the workdir. It runs the same on macOS and Linux.
