# Quoting and parameter expansion · 05 · Athens family wedding, place cards from the aunts' guest list

Three aunts typed the guest list for a wedding in Kifisia, Athens: mixed case, hyphens, an O'Neill-Karras. zsh's `(C)` `(U)` `(L)` flags tidy the names for place cards, and `(r:28::.:)` pads them with dots so the table number lines up.

**What it teaches**

- zsh case flags: `${(C)name}` capitalizes each word, `${(U)name}` and `${(L)name}` change the whole string
- `(C)` starts a new word after any non-letter, so `anna-maria` becomes `Anna-Maria`, and `mcgrath` becomes `Mcgrath`
- flags apply to every element of an array; inside double quotes a nested array needs `@` to stay an array, so `"${(j:, :)${(@C)guests}}"` joins names, not one long string
- `${(r:28::.:)name}` pads on the right with dots to a fixed width; `(l:...)` pads on the left
- bash 4 spells these `${name^^}` and `${name,,}`; macOS's bash 3.2 has neither

**Lesson steps**

1. Capitalize each word with (C) (`${(C)name}`)
2. Uppercase surnames and lowercase first names (`${(U)name}`)
3. Join a capitalized array without collapsing it (`${(j:, :)${(@C)array}}`)
4. Pad place cards with dot leaders (`${(r:28::.:)name}`)

**Files**

| File | Role |
| --- | --- |
| [`place_cards.zsh`](place_cards.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/05-athens-wedding-place-cards/place_cards.zsh
tests/run-examples.zsh 05-athens-wedding-place-cards
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
