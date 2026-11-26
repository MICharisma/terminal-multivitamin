# Navigation and files · 06 · Accra outdooring photos from a cousin's phone

After baby Akosua's outdooring (naming ceremony) in Accra, cousin Kofi hands over his phone's `IMG_` files. The family album uses dated names, a photo from last week already holds one of the names, and one photo on the plan is not on the phone. The script keeps safety copies first, then renames from a tab-separated plan without ever overwriting.

**What it teaches**

- `cp -p` keeps the original timestamps on a safety copy before renaming
- a tab-separated rename plan read with `while IFS=$'\t' read -r`
- `mv -n` never overwrites; checking `[[ -e ]]` first lets the script say why
- `--` stops a filename from being read as an option

**Lesson steps**

1. Keep timestamped safety copies before renaming (`cp -p`)
2. Read the rename plan line by line (`while IFS= read -r`)
3. Move without overwriting, and say why a photo stayed (`mv -n`)
4. Check the album folder (`ls -1`)

**Files**

| File | Role |
| --- | --- |
| [`rename_photos.zsh`](rename_photos.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/phone-import/2026-11-08_outdooring_03.jpg`](fixtures/phone-import/2026-11-08_outdooring_03.jpg) | Fixture copied into the script's temp folder |
| [`fixtures/phone-import/IMG_4410.JPG`](fixtures/phone-import/IMG_4410.JPG) | Fixture copied into the script's temp folder |
| [`fixtures/phone-import/IMG_4411.JPG`](fixtures/phone-import/IMG_4411.JPG) | Fixture copied into the script's temp folder |
| [`fixtures/phone-import/IMG_4412.JPG`](fixtures/phone-import/IMG_4412.JPG) | Fixture copied into the script's temp folder |
| [`fixtures/phone-import/IMG_4415.JPG`](fixtures/phone-import/IMG_4415.JPG) | Fixture copied into the script's temp folder |
| [`fixtures/renames.tsv`](fixtures/renames.tsv) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/06-accra-outdooring-photos/rename_photos.zsh
tests/run-examples.zsh 06-accra-outdooring-photos
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
