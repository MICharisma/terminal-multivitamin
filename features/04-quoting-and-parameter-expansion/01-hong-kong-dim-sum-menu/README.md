# Quoting and parameter expansion · 01 · Hong Kong dim sum teahouse, printing the menu board

A teahouse in Sheung Wan chalks its dim sum prices on a board: Har gow HK$38, a set for two, Lin Heung's lotus seed bun. Single quotes keep the dollar sign literal; double quotes expand `$38` away; joined quote pieces and a careful apostrophe finish the board.

**What it teaches**

- single quotes keep every character literal, `$` included: `'HK$38'`
- double quotes expand `$`, so `"HK$38"` prints `HK`: zsh reads `$38` as the (empty) 38th argument; bash and sh read `$3` then `8`
- inside double quotes `\$` is a literal dollar sign, and `"$price"` stays one word
- quoted pieces written side by side join into one word: `'HK$'"$price"`
- no quote can be escaped inside single quotes: close, add `\'`, reopen (`'Lin'\''s'`), or use double quotes

**Lesson steps**

1. Write a price with a literal dollar sign (`'...'`)
2. See double quotes expand $38 into nothing (`"..."`)
3. Escape the dollar inside double quotes (`\$`)
4. Join single-quoted and double-quoted pieces (`'HK$'"$price"`)
5. Put an apostrophe inside single quotes (`'...'\''...'`)

**Files**

| File | Role |
| --- | --- |
| [`menu_board.zsh`](menu_board.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/01-hong-kong-dim-sum-menu/menu_board.zsh
tests/run-examples.zsh 01-hong-kong-dim-sum-menu
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
