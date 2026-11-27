# ssh, scp, and rsync · 10 · Riga open-data bastion hop

RigaTech's open-data desk reaches `data.rigatech.gov.lv` only through
`bastion.rigatech.gov.lv`. A table of Host rows becomes an ssh config with
`ProxyJump`, and `ssh -G` shows the hop without opening a session.

**What it teaches**

- `ProxyJump` reaches an inner host through a bastion in one hop
- table-driven Host blocks keep the bastion and the target side by side

**Lesson steps**

1. Hold bastion and opendata rows in a table (`ProxyJump`)
2. Write Host blocks and ProxyJump for the inner host (`ProxyJump`)
3. Resolve opendata and show the ProxyJump bastion (`ProxyJump`)

**Files**

| File | Role |
| --- | --- |
| [`bastion_hop.zsh`](bastion_hop.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/10-riga-bastion-hop/bastion_hop.zsh
tests/run-examples.zsh 10-riga-bastion-hop
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
