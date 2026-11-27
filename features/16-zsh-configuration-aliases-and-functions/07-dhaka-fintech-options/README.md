# zsh configuration, aliases, and functions · 07 · Dhaka fintech option probe

A payments desk in Dhaka runs the same scripts on laptops and CI. Before enabling conveniences, they probe options with `[[ -o ]]`, then `setopt` / `unsetopt` null_glob to show the toggle.

**What it teaches**

- `setopt` turns an option on; `unsetopt` turns it off
- `[[ -o name ]]` tests whether an option is currently set
- a fintech desk probes interactive conveniences before enabling them in CI shells

**Lesson steps**

1. Probe whether key options are on (`[[ -o ]]`)
2. Turn null_glob on with setopt (`setopt`)
3. Turn it back off with unsetopt (`unsetopt`)

**Files**

| File | Role |
| --- | --- |
| [`option_probe.zsh`](option_probe.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/07-dhaka-fintech-options/option_probe.zsh
tests/run-examples.zsh 07-dhaka-fintech-options
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
