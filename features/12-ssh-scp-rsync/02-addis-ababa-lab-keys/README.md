# ssh, scp, and rsync · 02 · Addis Ababa Institute of Technology lab keys

The student lab at AAIT mints one ed25519 key per login. A small function with
`emulate -L zsh` and `setopt local_options` wraps `ssh-keygen`, stamps the
comment `student@aait.edu.et`, and prints only the basenames and comment — never
the key material.

**What it teaches**

- `ssh-keygen -t ed25519` makes a modern key pair
- `-f` sets the private-key path; the public key gets `.pub`
- `-N ''` leaves the key unlocked for a lab sandbox
- `-C` stores a comment such as `student@aait.edu.et`

**Lesson steps**

1. Mint an ed25519 key inside a function with local options (`ssh-keygen -t ed25519`)
2. Issue Hana Kebede's lab key with the AAIT comment (`ssh-keygen -t ed25519`)
3. Issue Dawit Tesfaye's key the same way (`ssh-keygen -t ed25519`)
4. List the public keys on the lab roster (`ssh-keygen -t ed25519`)

**Files**

| File | Role |
| --- | --- |
| [`lab_keys.zsh`](lab_keys.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/02-addis-ababa-lab-keys/lab_keys.zsh
tests/run-examples.zsh 02-addis-ababa-lab-keys
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
