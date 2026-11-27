# Editing streams with sed and awk · 01 · Fez pottery glaze recipes

A Fassi atelier in the medina keeps glaze recipes as one line per batch, with ounces of water and frit still written as `oz`. Before the electric kiln log goes to the cooperative, the apprentice normalizes units. First match, global substitution, and several `-e` edits each change what the sheet says.

**What it teaches**

- `sed 's/from/to/'` replaces only the first match on each line
- appending `g` to `s///` replaces every match on the line
- several `sed -e 'cmd'` expressions run in order on the same stream

**Lesson steps**

1. Replace only the first `oz` on each line (`sed 's/from/to/'`)
2. Replace every `oz` with the `g` flag (`sed 's/from/to/g'`)
3. Chain two edits with `sed -e` (`sed -e 'cmd'`)

**Files**

| File | Role |
| --- | --- |
| [`glaze_recipes.zsh`](glaze_recipes.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/01-fez-pottery-glaze-recipes/glaze_recipes.zsh
tests/run-examples.zsh 01-fez-pottery-glaze-recipes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
