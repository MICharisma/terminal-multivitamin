# Editing streams with sed and awk · 07 · Dakar fishing cooperative

Pirogues land at Yoff with a CSV line per crate: boat, species, kilograms. The smokehouse wants every `thiof` line; the ice truck wants anything at least forty kilograms. Pattern actions, numeric comparisons, and an `END` block that totals one species wrap the landing log.

**What it teaches**

- an `awk` pattern before `{action}` runs the action only on matching lines
- a regex pattern like `/species/` matches anywhere on the line
- a comparison pattern like `$3 >= 40` treats fields as strings unless numeric

**Lesson steps**

1. Match species with a regex pattern (`awk '/regex/'`)
2. Compare the kilogram field (`awk '$3 >= n'`)
3. Total one species in `END` (`awk END`)

**Files**

| File | Role |
| --- | --- |
| [`catch_log.zsh`](catch_log.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/landing-log.csv`](fixtures/landing-log.csv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/07-dakar-fishing-cooperative/catch_log.zsh
tests/run-examples.zsh 07-dakar-fishing-cooperative
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
