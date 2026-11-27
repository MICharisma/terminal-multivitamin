# Finding files with find and xargs · 05 · Vancouver game studio, counting source without node_modules

A small game studio in Vancouver is writing the README for *Salmon Run*, a 2D river game in TypeScript. Its own code is a handful of files, but the repository also holds `node_modules`, `.git`, and a generated `dist/` folder, so a plain `find -name '*.ts'` counts five times too many. `-prune` keeps `find` out of those folders, and `-maxdepth` lists the top level for the layout section.

**What it teaches**

- `-prune` stops `find` from going into a folder; `\( -name node_modules -o -name .git \) -prune -o -name '*.ts' -print` is the standard shape
- the trailing `-print` matters: without it, `find` prints the pruned folders as well
- `-path` matches the whole path as `find` prints it, so `salmon-run/dist` works and `dist` alone does not
- `-mindepth 1 -maxdepth 1` lists only the top level; put them before any test (GNU `find` warns otherwise)

**Lesson steps**

1. Count every .ts file, dependencies included (`find -name`)
2. Prune node_modules and .git, then print the rest (`find -prune -o -print`)
3. Leave out the final -print and see the pruned folders listed (`find -prune -o -print`)
4. Prune dist by its full path (`find -path`)
5. List only the top-level folders (`find -mindepth -maxdepth`)

**Files**

| File | Role |
| --- | --- |
| [`source_files.zsh`](source_files.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/05-vancouver-game-studio-prune/source_files.zsh
tests/run-examples.zsh 05-vancouver-game-studio-prune
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
