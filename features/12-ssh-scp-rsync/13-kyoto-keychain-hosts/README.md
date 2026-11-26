# ssh, scp, and rsync · 13 · Kyoto mokuhanga supplier Keychain hosts

A mokuhanga studio in Kyoto keeps an SSH host for its washi paper supplier.
macOS OpenSSH can store the key passphrase in the Keychain with `UseKeychain`
and load the key into the agent with `AddKeysToAgent`. This slot resolves both
with `ssh -G` and runs only on macOS.

**What it teaches**

- `UseKeychain yes` lets macOS OpenSSH store key passphrases in the Keychain
- `AddKeysToAgent yes` loads the key into the agent on first use
- `ssh -G` resolves both settings without opening a connection

**Lesson steps**

1. Write UseKeychain and AddKeysToAgent for the washi supplier (`UseKeychain`)
2. Resolve the supplier host and show UseKeychain (`UseKeychain`)
3. Confirm AddKeysToAgent is enabled on the same host (`AddKeysToAgent`)

**Files**

| File | Role |
| --- | --- |
| [`keychain_hosts.zsh`](keychain_hosts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root (macOS only):

```sh
features/12-ssh-scp-rsync/13-kyoto-keychain-hosts/keychain_hosts.zsh
tests/run-examples.zsh 13-kyoto-keychain-hosts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. On Linux the test runner skips it (`# requires: macos`).
