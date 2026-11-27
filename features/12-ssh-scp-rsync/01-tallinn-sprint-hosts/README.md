# ssh, scp, and rsync · 01 · Tallinn sprint staging hosts

A mobility startup in Tallinn keeps `staging-eu` and `staging-us` aliases for its
Bolt-lab internal hosts. The sprint script holds those aliases in an associative
array, writes a throwaway ssh config, and asks `ssh -G` what each alias resolves
to — no daemon, no network.

**What it teaches**

- a `Host` alias in an ssh config is the short name you type
- `HostName`, `User`, and `IdentityFile` fill in the real connection details
- `ssh -G -F config alias` prints the resolved settings without connecting

**Lesson steps**

1. Keep the sprint Host aliases in an associative array (`Host`)
2. Write HostName, User, and IdentityFile for each alias (`HostName`)
3. Resolve the EU staging host without connecting (`ssh -G`)
4. Confirm the US alias picks the matching IdentityFile (`IdentityFile`)
5. Show the deploy User from the resolved US block (`User`)

**Files**

| File | Role |
| --- | --- |
| [`staging_hosts.zsh`](staging_hosts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/01-tallinn-sprint-hosts/staging_hosts.zsh
tests/run-examples.zsh 01-tallinn-sprint-hosts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
