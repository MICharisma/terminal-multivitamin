# zsh configuration, aliases, and functions · 08 · Colombo school ZDOTDIR load order

An international school in Colombo images student MacBooks with a shared shell config. Setting `ZDOTDIR` to a temp tree shows `.zshenv` → `.zprofile` → `.zshrc` → `.zlogin` for a login+interactive shell — without writing to anyone's real home.

**What it teaches**

- `ZDOTDIR` relocates `.zshenv`, `.zprofile`, `.zshrc`, and `.zlogin` away from `$HOME`
- login+interactive zsh sources them in a fixed order
- a school laptop image can ship one ZDOTDIR tree without touching students' real homes

**Lesson steps**

1. Write the four startup files under a temp ZDOTDIR (`ZDOTDIR`)
2. Run login+interactive zsh and watch the order (`ZDOTDIR`)

**Files**

| File | Role |
| --- | --- |
| [`load_order.zsh`](load_order.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/16-zsh-configuration-aliases-and-functions/08-colombo-school-zdotdir/load_order.zsh
tests/run-examples.zsh 08-colombo-school-zdotdir
```

The script creates its own folder with `mktemp -d`, points `ZDOTDIR` at a temp config tree inside it, and deletes everything on exit. It never writes to your real home directory.
