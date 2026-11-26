# Contributing to Terminal Multivitamin

Every scenario in this catalog follows the same house rules. The reference
scenario is [Navigation and files · 03 · Reykjavík geothermal turbine inspection](features/01-navigation-and-files/03-reykjavik-geothermal-inspection/).
Copy its packaging, then vary the shell idioms.

## Idioms checklist

Review the thirteen siblings together before adding or changing a scenario. The
script is the product; the tests and metadata support it.

- [ ] Give the new example a different shape from every sibling. A shape is the
  structure of the code, not just the command: a single pipeline, a `for` loop
  over a glob, a `while read` over a plan file, a `case` router, a table held in
  an associative array, a function with local options, a subshell experiment,
  a before/after comparison. Never the same shape twice in one feature.
- [ ] Rotate shell constructs: arrays and `${#array}`, associative arrays with
  `${(kv)...}`, parameter flags (`(j: :)`, `(u)`, `(D)`, `(l:3::0:)`), modifiers
  (`:t`, `:h`, `:r`), anonymous functions, `emulate -L zsh`, `setopt local_options`,
  `[[ ]]` tests, `(( ))` arithmetic, process and command substitution.
- [ ] Prefer the portable form when BSD and GNU disagree; if there is no
  portable form, detect the flavor once (as in Kraków's `stat --version` check)
  and say so in the README.
- [ ] Keep the feature's lesson visible. Other features may appear when a real
  job would use them (a glob in a navigation example, a `sort` in a `du`
  ranking), but the folder's feature must be the star.

## The rules

### 1. Real names, always

Every folder, file, variable, function, and string a reader sees has a name that
means something in the scenario: `encomendas/natal/bolo-rei`, `camion-127.log`,
`summarize_day`, `$workdir`.

Never use `foo`, `bar`, `baz`, `hello`, `hello world`, `test.txt`, `file1`,
`mydir`, `example`, `demo`, `tmp1`, `x`, or similar stand-ins. If you are tempted
to write one, the scenario is not concrete enough yet.

| Instead of | Write |
| --- | --- |
| `mkdir -p a/b/c` | `mkdir -p encomendas/natal/bolo-rei` |
| `touch file{1..3}.txt` | `touch familia-mendes.txt cafe-alcantara.txt` |
| `for f in *.log` | `for log in logs/*.log` |
| `echo hello > test.txt` | `print "bearing 2: 4.1 mm/s, inside limit" > reading.txt` |

Content counts too: believable sample data (a permit log, brake readings, a
cupping score sheet), not lorem ipsum. Placeholder bytes are fine where only the
name or type matters, but give them a meaningful line of text.

### 2. One memorable scenario per folder, from around the world

Each folder is one real-world job. Across a feature's thirteen:

- **Places:** thirteen different cities or regions, mostly outside the USA. Do
  not reuse a place that another feature already uses.
- **Institutions:** spread across business, education, family, tech, art, music,
  and mechanical (plus science, nonprofit, government, hospitality...). Use each
  type at least once, and no type more than three times.
- **Fit:** the scenario's shape must clearly call for the technique. Truck
  numbers call for `<120-135>`; a release folder calls for `ln -sfn`; a phone's
  `IMG_` files call for a rename plan. If you have to explain why the job would
  use the technique, choose a different job.
- **Folder name:** `NN-place-scenario`, all lowercase ASCII (`03-reykjavik-geothermal-inspection`).

### 3. Moderate to complex, never trivial

Skip what a man page's first example already shows. A scenario needs enough
moving parts to show the technique under realistic pressure: a collision, an
empty match, a name starting with a dash, a BSD/GNU difference, a stale copy.
Order the thirteen roughly from moderate to complex, ending with a capstone.

### 4. Safe by construction

- Start with the sandbox prelude: `mktemp -d`, an `EXIT` trap that removes it,
  and `cd` into it. Never write outside `$workdir`.
- Copy fixtures from `${0:A:h}/fixtures` (zsh) into `$workdir`; never modify them
  in place.
- Use `set -o errexit -o nounset -o pipefail` (zsh, bash) or `set -eu` (POSIX sh).
- Guard every `rm -r` with `${var:?}` or a path that starts with `$workdir`.
- No network, no `sudo`, no writes to `$HOME`, no changes to system settings. A
  macOS-only scenario that changes a setting (for example `defaults write`) must
  write to its own domain and remove it in the trap.

### 5. Deterministic output

- Print paths relative to `$workdir` (`${PWD#$workdir/}`, `${file:t}`), never the
  temp path itself.
- Do not print dates, sizes in blocks, user names, or anything else that varies
  by machine. Make timestamps with `touch -t` or `zsh/datetime`.
- Prefer lowercase file names so order does not depend on locale.
- Avoid `print "-- heading"`: zsh's `print` reads a leading `-` as options. The
  catalog uses `== heading` instead.

### 6. A short header that says what it teaches

The script opens with a comment: feature, slot, and scenario title, then a
`Teaches:` list with code in backticks. The example README repeats that list, so
write it for both readers. Inside the code, comment only on constraints the code
cannot show; do not narrate what the next line does.

```zsh
#!/usr/bin/env zsh
# Navigation and files · 03 · Reykjavík geothermal turbine inspection
#
# Teaches:
#   - `cdpath` lets `cd hellisheidi` work from any folder, even from `/`
#   - ...
```

A macOS-only script adds `# requires: macos` as its second line, checks
`$OSTYPE`, and exits 2 with a message elsewhere.

### 7. Highlighting markers and lesson metadata

Follow the multivitamin format (the same one rubyllm-multivitamin uses):

- `# region: name` and `# endregion: name` around the lines a step points at.
  Names are kebab-case and unique within the script. Regions do not nest.
- `# focus: expr` right after `# region:`. `expr` must appear verbatim on one of the
  region's lines.
- `lesson.json` lists steps in teaching order. Each step has a `label` (a
  sentence in the scenario's words), an `api` (the command, flag, or idiom), and
  `regions` with a `role`: `primary` (the step's own code), `setup` (what it
  builds on), or `result` (where its effect shows).
- Every step's `api` must appear in the feature's `feature.json` `covers`, and every
  `covers` entry must be taught by some step. Keep `covers` sorted.
- Every region in the script must be used by a step.

`python3 tests/check_metadata.py` enforces all of the above, plus the schemas in
`schema/`.

## Adding a scenario

1. Pick the slot in the feature's `README.md`. Planned titles are proposals.
2. Create `NN-place-scenario/` with the script, `fixtures/` if needed, and
   `lesson.json`. Mark the script executable (`chmod +x`).
3. Run it, read the output, then record it:
   `tests/run-examples.zsh --update NN-place-scenario` and review the diff of `expected.txt`.
4. Write the example `README.md`: scenario paragraph, "What it teaches", lesson steps,
   files, "Try it".
5. Add any new `api` to `feature.json` `covers`.
6. Update the feature `README.md` (slot link, "What each scenario adds") and the
   root `README.md` counts.
7. Run `tests/run-examples.zsh` and `python3 tests/check_metadata.py`.

## Adding a feature

1. Create `features/NN-feature/` with `README.md` and `feature.json`
   (`feature` is the folder name without `NN-`).
2. Add the folder to `multivitamin.json` `features`, in catalog order.
3. Build all thirteen slots before marking the feature built in the root README.
