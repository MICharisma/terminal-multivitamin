# Environment and PATH

What a process inherits: `export` and `typeset -x`, `env` / `env -i`,
one-shot `NAME=value command`, zsh's tied `path` array, `hash -r`,
`command -v` / `whence` / `type` / `which`, `set -a` with a `.env` file,
`ZDOTDIR` startup order, PATH hygiene, portable `sh` and bash PATH editing,
and macOS `path_helper`.

zsh vs bash vs sh at a glance:

| Idea | zsh | bash | POSIX sh |
| --- | --- | --- | --- |
| Edit PATH as a list | `$path` array, tied to `$PATH` | `PATH=dir:$PATH` string | same as bash |
| Drop duplicate dirs | `typeset -U path` | rebuild the string | rebuild the string |
| Clear command cache | `hash -r` | `hash -r` / `hash -p` | no portable hash |
| Where is this command? | `whence -v`, `command -v` | `type -a`, `command -v` | `command -v` |
| Login PATH on macOS | `path_helper -s` | same | same |

Official references: `man zshparam` (`path`, `PATH`), `man zshbuiltins`
(`export`, `typeset`, `whence`, `hash`), `man bash` ("Shell Variables"),
and on macOS `man path_helper`.

## Examples (13 of 13 built)

01. [Bucharest pharmacy, exporting the batch number for every label printer](01-bucharest-pharmacy-labels/) — available
02. [Colombo tea tasting room, scoring cups in a clean environment](02-colombo-tea-tasting/) — available
03. [Medellín fashion school, which dxf_plot the CAD lab runs](03-medellin-fashion-cad/) — available
04. [Almaty mountain weather desk, editing PATH as a zsh array](04-almaty-path-array/) — available
05. [Recife family kitchen, marking the recipe year for every helper script](05-recife-family-recipes/) — available
06. [Valletta dive school, asking the shell where each tool is](06-valletta-dive-tools/) — available
07. [Yangon puppet theatre, loading the evening show from a .env file](07-yangon-puppet-env/) — available
08. [Tromsø northern lights desk, watching zsh startup files under ZDOTDIR](08-tromso-zdotdir/) — available
09. [Córdoba community radio, one-shot environment on the jingle command](09-cordoba-radio-jingle/) — available
10. [Kampala clinic IT closet, refusing a dangerous PATH](10-kampala-clinic-path/) — available
11. [Baku carpet workshop, editing PATH in portable sh](11-baku-carpet-path/) — available
12. [Penang fab lab, PATH and hashing in bash](12-penang-fab-lab/) — available
13. [Osaka brewery IT loft, reading path_helper's PATH](13-osaka-path-helper/) — available, macOS only

## What each scenario adds

| Slot | Institution | What it adds |
| --- | --- | --- |
| 01 | Pharmacy (business) | assignment vs `export`, `printenv`, `export -p`, `unset` |
| 02 | Tea tasting (business) | `env -i`, inherited vs cleaned environment |
| 03 | Fashion school (education) | PATH order, `whence -p`, planted hash + `hash -r` |
| 04 | Weather desk (science) | tied `path` array, prepend/append, `typeset -U`, `(F)` |
| 05 | Family kitchen (family) | `typeset -x` / `-r` / `+x` |
| 06 | Dive school (education) | `command -v`, `whence -v`, `type -a`, `which` |
| 07 | Puppet theatre (art) | `set -a`, `. ./file`, `set +a` |
| 08 | Aurora desk (hospitality) | `ZDOTDIR`, `.zshenv` / `.zprofile` / `.zshrc` / `.zlogin` |
| 09 | Community radio (music) | `NAME=value command` one-shot env |
| 10 | Clinic IT (tech) | drop `.` and world-writable PATH entries |
| 11 | Carpet workshop (art) | POSIX `sh` PATH prepend/restore, `command -v` |
| 12 | Fab lab (tech) | bash `hash` / `hash -p` / `hash -r`, `type -a` |
| 13 | Brewery IT (business) | macOS `path_helper -s`, `eval`, prepend with `path` |

See [CONTRIBUTING.md](../../CONTRIBUTING.md) before changing a slot.
