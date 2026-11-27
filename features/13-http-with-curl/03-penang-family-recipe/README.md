# HTTP with curl · 03 · Penang family laksa recipe

Auntie Mei keeps the family's Nyonya laksa card on a tiny kitchen board. Before
she posts it, `curl -fsSL` fails loud on the missing path; after it lands, the
same flags stream the recipe to stdout.

**What it teaches**

- `curl -fsSL` fails loud on HTTP errors (`-f`), stays silent (`-s`), shows curl errors (`-S`), and follows redirects (`-L`)

**Lesson steps**

1. Fail loud when the recipe card is still missing (`curl -fsSL`)
2. Fetch auntie Mei's laksa card once it is posted (`curl -fsSL`)

**Files**

| File | Role |
| --- | --- |
| [`family_recipe.zsh`](family_recipe.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`fixtures/laksa-nyonya.txt`](fixtures/laksa-nyonya.txt) | The family recipe text |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/13-http-with-curl/03-penang-family-recipe/family_recipe.zsh
tests/run-examples.zsh 03-penang-family-recipe
```

The script creates its own folder with `mktemp -d`, serves the recipe on
`127.0.0.1`, and deletes the sandbox on exit.
