# Homebrew

Homebrew is the package manager most macOS Terminal users reach for (and it
runs on Linux too). This feature covers the read-only side of the craft: finding
where Homebrew lives (`brew --prefix`, `--cellar`, `--cache`), inspecting
formulae and casks (`brew info --json`, `brew deps`, `brew leaves`, `brew outdated`),
declaring a machine with a `Brewfile` (`brew bundle check`, `brew bundle list`,
`brew bundle dump`), listing services, and reading `brew doctor` without
changing the system.

Every scenario stubs `brew` with a fixture script under `$workdir/bin` and a fake
prefix tree. Nothing is installed, upgraded, or linked outside the temp folder.
That keeps the examples safe on CI Linux runners and on a real Mac alike.

| Idea | Command | Notes |
| --- | --- | --- |
| Where Homebrew lives | `brew --prefix` | Apple Silicon `/opt/homebrew`, Intel `/usr/local` |
| Where a formula would land | `brew --prefix FORMULA` | Works even before install |
| Machine-readable formula info | `brew info --json=v1 FORMULA` | `v2` adds casks |
| Declarative inventory | `Brewfile` + `brew bundle check` | Exit 0 when satisfied |
| What you asked for vs deps | `brew leaves` vs `brew list` | Leaves omit dependencies |
| Services Homebrew manages | `brew services list` | Read-only listing here |

Official references: `man brew`, [docs.brew.sh](https://docs.brew.sh), and
[Brew Bundle](https://docs.brew.sh/Brew-Bundle-and-Brewfile).

## Examples (13 of 13 built)

01. [Amman coworking desk Homebrew prefix](01-amman-coworking-prefix/) — available
02. [Tallinn coding bootcamp Brewfile audit](02-tallinn-bootcamp-brewfile/) — available
03. [Porto family laptop formula cards](03-porto-family-formula-info/) — available
04. [Kyoto print restoration lab casks vs formulae](04-kyoto-restoration-casks/) — available
05. [Lagos highlife studio dependency map](05-lagos-studio-deps/) — available
06. [Valparaíso shipyard leaves vs list](06-valparaiso-shipyard-leaves/) — available
07. [Brisbane cafe POS outdated report](07-brisbane-cafe-outdated/) — available
08. [Bucharest museum digitization doctor](08-bucharest-museum-doctor/) — available
09. [Antananarivo CS lab taps](09-antananarivo-lab-taps/) — available
10. [Québec City SaaS brew services board](10-quebec-saas-services/) — available
11. [Medellín conservatory Brewfile dump](11-medellin-conservatory-dump/) — available
12. [Doha hotel IT cellar and cache paths](12-doha-hotel-cellar/) — available
13. [Addis Ababa GIS desk bundle check](13-addis-ababa-gis-bundle/) — available

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Coworking (tech) | `brew --prefix`, `brew --prefix FORMULA`, PATH membership |
| 02 | Coding bootcamp (education) | Brewfile line parsing with `while read`, brew/cask/tap counts |
| 03 | Family laptop (family) | `brew info --json=v1`, extracting name and versions |
| 04 | Print lab (art) | `case` router over Brewfile kinds; formula vs cask |
| 05 | Recording studio (music) | `brew deps`, `brew uses`, associative dependency map |
| 06 | Shipyard (mechanical) | `brew leaves` vs `brew list`, `comm` set comparison |
| 07 | Cafe POS (business) | `brew outdated --json`, function with `emulate -L zsh` |
| 08 | Museum NGO (nonprofit) | `brew doctor` stub, process substitution filter |
| 09 | University lab (education) | `brew tap` listing, unique tap array from Brewfile |
| 10 | SaaS startup (tech) | `brew services list`, status table in an associative array |
| 11 | Conservatory (music) | `brew bundle dump --file`, diff against the committed Brewfile |
| 12 | Hotel IT (hospitality) | `brew --cellar`, `--cache`, formatted multi-path inventory |
| 13 | GIS desk (government) | `brew bundle check --verbose`, conditional Brewfile, anonymous function |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
