# macOS system tools · 07 · Muscat hotel Wi-Fi inventory

The IT closet at a Muscat harbor hotel inventories hardware ports before a conference. `networksetup -listallhardwareports` is read-only; a while-read loop records that at least one Device line exists, without printing machine-specific names.

**What it teaches**

- `networksetup -listallhardwareports` lists ports (read-only)
- `while IFS= read -r` walks each line of the inventory
- the ledger only records whether a Device line appeared

**Lesson steps**

1. List every hardware port (`networksetup -listallhardwareports`)
2. Walk the inventory line by line (`while IFS= read -r`)

**Files**

| File | Role |
| --- | --- |
| [`wifi_inventory.zsh`](wifi_inventory.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/18-macos-system-tools/07-muscat-wifi-inventory/wifi_inventory.zsh
tests/run-examples.zsh 07-muscat-wifi-inventory
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It needs macOS; on Linux it prints a message and exits 2, and the test runner skips it.
