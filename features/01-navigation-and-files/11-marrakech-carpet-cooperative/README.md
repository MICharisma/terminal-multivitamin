# Navigation and files · 11 · Marrakech carpet cooperative named folders

A women's carpet cooperative in Marrakech keeps export orders four folders deep and dye recipes three folders deep. Named directories (`hash -d`) turn those into `~orders` and `~coop`, which work with `cd`, `cp` and `ls`, and `print -D` prints paths back in the short form.

**What it teaches**

- `hash -d` gives a deep folder a short name you can `cd` to as `~name`
- `print -D` (and the `${(D)...}` flag) rewrite a path using those names
- the longest matching name wins, so `~orders` beats `~coop` inside orders
- `~name` works anywhere a path does: `ls`, `cp`, and in the middle of a longer path

**Lesson steps**

1. Name two deep folders (`hash -d`)
2. cd by name and print where you are (`cd ~name`)
3. Abbreviate paths with the names (`${(D)path}`)
4. Use the names inside ordinary commands (`~name`)

**Files**

| File | Role |
| --- | --- |
| [`named_dirs.zsh`](named_dirs.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/11-marrakech-carpet-cooperative/named_dirs.zsh
tests/run-examples.zsh 11-marrakech-carpet-cooperative
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
