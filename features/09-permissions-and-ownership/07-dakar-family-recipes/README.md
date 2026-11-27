# Permissions and ownership · 07 · Dakar family recipe book, a read-only file that still gets replaced

The Ndiaye family in Dakar keeps Mame Aminata's thieboudienne recipe on the family computer, made read-only so nobody "improves" it. Before Tabaski, one cousin tries to append a line and is refused, but a nephew writes a scaled-up version and `mv`s it over the original, and that works, because replacing or deleting a name is the folder's business, not the file's. Each attempt sits in a zsh `{ ... } always { ... }` block that restores the original, and the last step locks the folder as well.

**What it teaches**

- `chmod a-w` stops writes into a file: `>>` fails with "permission denied"
- replacing the file (write a new one, then `mv` it over) is a folder operation, so it works and quietly leaves the new file's mode behind
- `rm` of a read-only file also only needs the folder's `w`; `rm` asks first only on a terminal
- `[[ -w ]]` tests before you try; protecting a file for real means `a-w` on its folder too
- zsh's `{ ... } always { ... }` restores the original after every attempt, even a failed one

**Lesson steps**

1. Make the recipe read-only for everyone (`chmod a-w`)
2. Appending to it is refused (`[[ -w ]]`)
3. Replacing it with mv works and resets the mode (`mv`)
4. Deleting it works too (`rm`)
5. Restore the original after every attempt (`{ } always { } restore`)
6. Lock the folder to protect the file for real (`chmod a-w`)

**Files**

| File | Role |
| --- | --- |
| [`protect_recipe.zsh`](protect_recipe.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/09-permissions-and-ownership/07-dakar-family-recipes/protect_recipe.zsh
tests/run-examples.zsh 07-dakar-family-recipes
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
