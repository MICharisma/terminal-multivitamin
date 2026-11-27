# Searching text with grep · 03 · Chiang Mai lacquer atelier, filtering this week's orders

A lacquer atelier in Ban Tawai, Chiang Mai, takes orders for bowls, trays, vases and boxes with gold-leaf or silver-leaf finishes. Extended regex (`grep -E`) selects bowls or trays, groups the leaf finishes, and asks for sizes with two or more digits.

**What it teaches**

- `grep -E` (or `egrep`) turns on extended regular expressions: `|`, `+`, `?`, `()`
- `bowl|tray` matches either word; `(gold|silver)-leaf` groups an alternative
- `x{2,}` needs `-E` (or `\{2,\}` in basic regex); basic `grep` treats `{}` literally on some systems
- prefer `grep -E` over the `egrep` spelling; both exist, `-E` is the portable long form

**Lesson steps**

1. Match bowl or tray with alternation (`grep -E`)
2. Group alternatives for leaf finishes (`grep -E (...)`)
3. Match two or more digits with {2,} (`grep -E {n,}`)
4. Combine anchors, groups and .* (`grep -E ^...`)

**Files**

| File | Role |
| --- | --- |
| [`lacquer_orders.zsh`](lacquer_orders.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/05-searching-text-with-grep/03-chiang-mai-lacquer-orders/lacquer_orders.zsh
tests/run-examples.zsh 03-chiang-mai-lacquer-orders
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
