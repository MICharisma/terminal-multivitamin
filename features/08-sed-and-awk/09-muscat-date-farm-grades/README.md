# Editing streams with sed and awk · 09 · Muscat date farm grades

A Nizwa farm grades khalas, fard, and naghal lots with weight and moisture in a tab file. The souq wants aligned columns on the packing slip; export needs moisture to two decimals; the yard foreman keeps a zsh table of which packer owns each variety.

**What it teaches**

- `awk printf` formats numbers without the default newline `print` adds
- `% width` and `%-width` align text in fixed columns
- `%.2f` rounds a field to two decimal places for a moisture report

**Lesson steps**

1. Align variety and grade with `printf` (`awk printf`)
2. Format moisture with `%.2f` (`printf "%.2f"`)
3. Map varieties to packers in zsh (`typeset -A`)

**Files**

| File | Role |
| --- | --- |
| [`date_grades.zsh`](date_grades.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/grading.tsv`](fixtures/grading.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/08-sed-and-awk/09-muscat-date-farm-grades/date_grades.zsh
tests/run-examples.zsh 09-muscat-date-farm-grades
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
