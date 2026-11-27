# Environment and PATH · 08 · Tromsø northern lights desk, watching zsh startup files under ZDOTDIR

The northern lights desk in Tromsø relocates zsh's startup files with `ZDOTDIR` and watches which ones run: every shell reads `.zshenv`, interactive shells add `.zshrc`, login shells add `.zprofile` and `.zlogin`.

**What it teaches**

- `ZDOTDIR` relocates `.zshenv`, `.zprofile`, `.zshrc`, `.zlogin` for a clean experiment
- `.zshenv` runs for every zsh; `.zprofile` for login shells; `.zshrc` for interactive shells
- `zsh -f` skips all of them; `zsh -i` is interactive; `zsh -l` is login
- put PATH exports in `.zshenv` only if every script should see them; prefer `.zprofile` for login PATH

**Lesson steps**

1. Run a non-interactive shell: zshenv only (`ZDOTDIR`)
2. Run an interactive shell: add zshrc (`zsh -i`)
3. Run a login shell: add zprofile and zlogin (`zsh -l`)
4. Run login interactive: all four files (`zsh -il`)

**Files**

| File | Role |
| --- | --- |
| [`startup_order.zsh`](startup_order.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/11-environment-and-path/08-tromso-zdotdir/startup_order.zsh
tests/run-examples.zsh 08-tromso-zdotdir
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
