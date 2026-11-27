# ssh, scp, and rsync · 11 · Amman campus dashboard tunnel

A student at the University of Jordan reaches an internal dashboard by
forwarding local port `18080` to `localhost:8080` on `portal.ju.edu.jo`. The
script writes `LocalForward` into a config and checks it with `ssh -G` — no
tunnel is left open.

**What it teaches**

- `LocalForward` maps a local port to a host:port on the far side of SSH
- `ssh -G` shows the forward as `localforward` without opening the tunnel

**Lesson steps**

1. Write LocalForward 18080 to the campus portal's localhost:8080 (`LocalForward`)
2. Resolve the campus-dashboard alias and show the forward (`LocalForward`)

**Files**

| File | Role |
| --- | --- |
| [`campus_tunnel.zsh`](campus_tunnel.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/12-ssh-scp-rsync/11-amman-campus-tunnel/campus_tunnel.zsh
tests/run-examples.zsh 11-amman-campus-tunnel
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
