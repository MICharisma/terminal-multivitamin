# Globbing and expansion · 07 · Ljubljana beekeeping cooperative label photos

A beekeeping cooperative near Ljubljana photographed jars of acacia, linden, chestnut and wildflower honey for new labels. The printer in Kranj gets finals only: JPEGs and the PNG logo, no drafts, no camera RAW files. Extended glob patterns express "everything except" directly, and the option stays switched on only where it is needed.

**What it teaches**

- `extended_glob`, switched on only inside a function (`emulate -L zsh`) or an anonymous function (`setopt local_options`)
- `^pattern` matches everything except the pattern
- `pattern~exclusion` keeps matches of the first part that miss the second
- `(a|b)` alternation and `*.(jpg|png)` pick between several spellings

**Lesson steps**

1. Turn on extended_glob only inside a function (`setopt extended_glob`)
2. Keep JPEG and PNG finals, excluding drafts (`pattern~exclusion`)
3. Count everything that is not a camera RAW (`^pattern`)
4. Deliver the finals to the printer (`cp`)
5. Pick two honeys with alternation (`(a|b)`)

**Files**

| File | Role |
| --- | --- |
| [`deliver_finals.zsh`](deliver_finals.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/07-ljubljana-honey-labels/deliver_finals.zsh
tests/run-examples.zsh 07-ljubljana-honey-labels
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
