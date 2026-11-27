# Navigation and files · 08 · Kigali moto-taxi fare app release switch

A Kigali startup runs a moto-taxi fare API. Each deploy unpacks into a dated release folder, and a `current` symlink says which one is live. The fares went up on the 26th; switching takes one `ln -sfn`, and so does rolling back. The script also shows the stray link `ln -sf` leaves behind when `-n` is forgotten.

**What it teaches**

- `ln -s` makes a `current` symlink that points at one release folder
- `readlink` shows where a symlink points without following it
- `ln -sfn` replaces the link itself; without `-n`, `ln` follows the old link into a folder and drops a stray link inside it
- rolling back is the same one-line `ln -sfn`

**Lesson steps**

1. Point current at the first release (`ln -s`)
2. See what ln -sf does to a link that points at a folder (`ln -sf`)
3. Replace the link itself with ln -sfn (`ln -sfn`)
4. Roll back and read where current points (`readlink`)

**Files**

| File | Role |
| --- | --- |
| [`switch_release.zsh`](switch_release.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/08-kigali-release-switch/switch_release.zsh
tests/run-examples.zsh 08-kigali-release-switch
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
