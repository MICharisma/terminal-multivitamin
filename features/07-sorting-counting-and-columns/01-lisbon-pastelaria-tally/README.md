# Sorting, counting, and columns · 01 · Lisbon pastelaria, tallying the 23 December orders

Back at the pastelaria in Belém from Navigation and files, the counter staff write one line per cake ordered for collection on 23 December, in the order customers ask. The bakers need a count per cake, and the shop window board needs them ranked. `sort | uniq -c` does the counting, and explicit sort keys make the ranking the same on any machine.

**What it teaches**

- `uniq -c` only merges neighbouring lines, so it needs `sort` in front of it
- `sort | uniq -c | sort -rn` ranks items by how often they occur
- `uniq -c` pads its counts to different widths on BSD and GNU; `read -r count item` drops the padding so `printf` can set its own
- `sort -rn` leaves equal counts to sort's last-resort rule (GNU reverses that too); `sort -k1,1nr -k2,2` ranks by count and then breaks ties alphabetically, everywhere

**Lesson steps**

1. See uniq -c miscount an unsorted order book (`uniq -c`)
2. Sort first, then count each cake (`sort | uniq -c`)
3. Rank by count to find the best seller (`sort -rn`)
4. Break ties alphabetically with two keys (`sort -k1,1nr -k2,2`)

**Files**

| File | Role |
| --- | --- |
| [`order_tally.zsh`](order_tally.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |
| [`fixtures/orders-2026-12-23.txt`](fixtures/orders-2026-12-23.txt) | Fixture copied into the script's temp folder |

**Try it**

From the repository root:

```sh
features/07-sorting-counting-and-columns/01-lisbon-pastelaria-tally/order_tally.zsh
tests/run-examples.zsh 01-lisbon-pastelaria-tally
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
