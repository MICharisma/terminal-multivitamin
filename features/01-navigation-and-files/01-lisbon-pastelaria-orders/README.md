# Navigation and files · 01 · Lisbon pastelaria Christmas orders

A pastelaria near the Jerónimos monastery in Belém takes Christmas orders for bolo-rei and pastéis de nata. Before the rush, the manager builds a folder for each product, walks into each one to drop order slips for a family, a café, a hotel and a school, then lists what is there. The script runs twice in real life, so `mkdir -p` has to be safe to repeat.

**What it teaches**

- `mkdir -p` builds a nested folder tree in one call and is safe to rerun
- `cd` with relative paths (`a/b/c`, `..`) and reading where you are from `$PWD`
- `touch` creates empty order slips; `ls -F` marks folders with a trailing `/`
- plain `mkdir` refuses a folder that already exists

**Lesson steps**

1. Build the whole order tree in one call (`mkdir -p`)
2. Walk into a product folder and leave order slips (`cd`)
3. List folders with ls -F and slips one per line (`ls -F`)
4. Rerun mkdir -p safely; plain mkdir refuses an existing folder (`mkdir`)

**Files**

| File | Role |
| --- | --- |
| [`christmas_orders.zsh`](christmas_orders.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/01-navigation-and-files/01-lisbon-pastelaria-orders/christmas_orders.zsh
tests/run-examples.zsh 01-lisbon-pastelaria-orders
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
