# Homebrew · 06 · Valparaíso shipyard leaves vs list

ASMAR's training workshop in Valparaíso installs cmake, ninja, and python for apprentice welders' CAD scripts. Before reclaiming disk, the foreman diffs `brew list` against `brew leaves` with `comm` to see which libraries are only dependencies.

**What it teaches**

- `brew list` names every installed formula, including dependencies
- `brew leaves` keeps only formulae you asked for (nothing else depends on them)
- `comm` compares two sorted lists: only-left, only-right, and both

**Lesson steps**

1. List every installed formula (`brew list`)
2. List only the leaves you asked for (`brew leaves`)
3. Compare list and leaves with comm (`comm`)

**Files**

| File | Role |
| --- | --- |
| [`leaves_vs_list.zsh`](leaves_vs_list.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/`](fixtures/) | Stub `brew` for list and leaves |

**Try it**

From the repository root:

```sh
features/15-homebrew/06-valparaiso-shipyard-leaves/leaves_vs_list.zsh
tests/run-examples.zsh 06-valparaiso-shipyard-leaves
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux (Homebrew is stubbed from fixtures).
