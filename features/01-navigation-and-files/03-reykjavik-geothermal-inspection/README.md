# Navigation and files · 03 · Reykjavík geothermal turbine inspection

An engineer doing the monthly vibration round at the Hellisheiði and Nesjavellir geothermal plants keeps readings in identically shaped folders: plant, turbine, month, vibration. `cdpath` gets her to a plant from anywhere, and zsh's two-argument `cd` swaps `turbine-2` for `turbine-3`, or one plant for the other, while keeping the rest of the path.

**What it teaches**

- `cdpath` lets `cd hellisheidi` work from any folder, even from `/`
- a relative `cd` still looks in the current folder first, then in `cdpath`
- zsh's two-argument `cd old new` swaps one word of the current path for another
- `setopt cd_silent` stops `cd` from echoing the folder it found through `cdpath`

**Lesson steps**

1. Jump to a plant from anywhere with cdpath (`cdpath`)
2. Walk down to this month's vibration readings (`cd`)
3. Swap turbine-2 for turbine-3 in the current path (`cd old new`)
4. Swap the plant and keep the rest of the path (`cd old new`)

**Files**

| File | Role |
| --- | --- |
| [`turbine_round.zsh`](turbine_round.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/03-reykjavik-geothermal-inspection/turbine_round.zsh
tests/run-examples.zsh 03-reykjavik-geothermal-inspection
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
