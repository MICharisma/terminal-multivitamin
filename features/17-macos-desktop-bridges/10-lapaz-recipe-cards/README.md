# macOS desktop bridges · 10 · La Paz family recipe cards to HTML

The Mamani family in La Paz keeps salteña recipes as Terminal here-documents and wants HTML cards for a cousin's phone. `textutil -stdin -format txt -convert html` reads the here-doc and writes `saltena-card.html`.

**What it teaches**

- a here-document feeds recipe text without a temporary .txt file
- `textutil -stdin -format txt -convert html` converts that stream to HTML
- the HTML card lands beside the script's other kitchen files

**Lesson steps**

1. Feed the salteña recipe from a here-document (`here-document`)
2. Convert stdin text to an HTML card (`textutil -stdin`)

**Files**

| File | Role |
| --- | --- |
| [`recipe_card.zsh`](recipe_card.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/17-macos-desktop-bridges/10-lapaz-recipe-cards/recipe_card.zsh
tests/run-examples.zsh 10-lapaz-recipe-cards
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
