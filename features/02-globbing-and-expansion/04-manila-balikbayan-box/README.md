# Globbing and expansion · 04 · Quezon City family balikbayan box lists

A family in Quezon City coordinates balikbayan boxes from relatives in Dubai, Toronto and Milan: a folder per relative, a few shared files, and a `pinakabago` (latest) link. Glob qualifiers sort out folders, files and links, find the relative who has not sent a list, and look for a spreadsheet that never arrived without the script erroring.

**What it teaches**

- glob qualifiers filter by file type: `(.)` plain files, `(/)` folders, `(@)` symlinks
- `(-/)` follows symlinks first, so a link to a folder counts as a folder
- qualifiers combine: `(/^F)` is "folders that are not full", i.e. empty
- `(N)` makes an empty match an empty list instead of an error
- `${~pattern}` lets a pattern stored in a variable glob when expanded, but only outside double quotes: `"${~pattern}"` stays literal text

**Lesson steps**

1. Ask for folders, files, and symlinks by qualifier (`(/)`)
2. Glob a pattern stored in a variable (`${~pattern}`)
3. Find empty folders by combining qualifiers (`(/^F)`)
4. Get an empty list instead of an error (`(N)`)
5. Read only regular files one level down (`(.)`)

**Files**

| File | Role |
| --- | --- |
| [`box_inventory.zsh`](box_inventory.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/02-globbing-and-expansion/04-manila-balikbayan-box/box_inventory.zsh
tests/run-examples.zsh 04-manila-balikbayan-box
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
