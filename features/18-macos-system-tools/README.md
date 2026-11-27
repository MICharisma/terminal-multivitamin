# macOS system tools

Preferences, Spotlight metadata, sleep assertions, launch agents, disks, and
network configuration from Terminal: `defaults`, `mdfind` / `mdls`, `caffeinate`,
`pmset`, `launchctl` / `plutil`, `diskutil`, and `networksetup`.

These tools are macOS-only. Every script starts with `# requires: macos`, checks
`$OSTYPE`, and exits 2 elsewhere; the Linux CI job skips them, and the macOS job
runs them with `--macos-only`.

Safety rules for this feature:

- `defaults` only writes the throwaway domain `com.micharisma.multivitamin.*` and
  deletes it in the `EXIT` trap
- `pmset`, `diskutil`, and `networksetup` are read-only; machine-specific values
  are normalized before printing
- launch agents are `plutil -lint`ed in a temp plist; bootstrap is printed as
  `would:` rather than loaded persistently
- no `sudo`, no power changes, no network reconfiguration, no disk erase

Official references: `man defaults`, `man mdls`, `man mdfind`, `man caffeinate`,
`man pmset`, `man launchctl`, `man plutil`, `man diskutil`, `man networksetup`.

## Examples (13 of 13 built)

01. [Yerevan prefs scratchpad for a workshop app](01-yerevan-prefs-scratchpad/) — available, macOS only
02. [Dar es Salaam clinic forms, reading Spotlight metadata](02-daressalaam-clinic-forms/) — available, macOS only
03. [Bilbao overnight render under caffeinate](03-bilbao-overnight-render/) — available, macOS only
04. [Rabat facilities power audit](04-rabat-power-audit/) — available, macOS only
05. [Vilnius backup agent plist lint](05-vilnius-backup-agent/) — available, macOS only
06. [Cartagena library disk check](06-cartagena-disk-check/) — available, macOS only
07. [Muscat hotel Wi-Fi inventory](07-muscat-wifi-inventory/) — available, macOS only
08. [Lhasa archive catalog queries](08-lhasa-archive-catalog/) — available, macOS only
09. [Split harbor watch with caffeinate -i](09-split-harbor-watch/) — available, macOS only
10. [Ouagadougou radio prefs export/import](10-ouagadougou-radio-prefs/) — available, macOS only
11. [Cebu school handout metadata](11-cebu-school-handouts/) — available, macOS only
12. [Lviv print shop launch agent dry-run](12-lviv-print-agent/) — available, macOS only
13. [Ushuaia field station night kit](13-ushuaia-field-station/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Tech workshop | `defaults write` / `read` / `delete` on a throwaway domain |
| 02 | Clinic (health/education) | `mdls -name` over intake form files |
| 03 | Animation studio (art) | `caffeinate -t` wrapping a short render stand-in |
| 04 | Facilities (mechanical) | read-only `pmset -g` with awk-normalized keys |
| 05 | Tech co-op | `plutil -lint` on a here-doc launch agent plist |
| 06 | Public library (education) | `diskutil info /` with Mount Point normalized |
| 07 | Hotel (hospitality) | `networksetup -listallhardwareports` normalized |
| 08 | Archive (nonprofit) | `mdfind` query strings from an associative table |
| 09 | Harbor workshop (mechanical) | `caffeinate -i` around a background watch |
| 10 | Community radio (music) | `defaults export` / `import` round trip |
| 11 | School (education) | `mdls -raw` via process substitution |
| 12 | Print shop (business) | `launchctl print` shape as `would:` plus lint |
| 13 | Field station (science) | capstone: defaults + caffeinate + mdls |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
