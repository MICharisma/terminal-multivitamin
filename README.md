# Terminal Multivitamin

Realistic macOS Terminal and command-line examples, thirteen per feature, with
lesson metadata so [multivitamin-web](https://github.com/MICharisma/multivitamin-web)
can show each one with its source highlighted step by step. This is the Terminal sibling of
[RubyLLM Multivitamin](https://github.com/MICharisma/rubyllm-multivitamin) and
[Stimulus Multivitamin](https://github.com/MICharisma/stimulus-multivitamin).

| Supplement Facts | |
| --- | --- |
| Serving size | 1 scenario (one runnable script) |
| Servings per feature | 13 |
| Features planned | 18 |
| Features built | 14 |
| Scenarios built | 182 of 234 |
| Active ingredient | zsh 5.9 on macOS (the default shell since Catalina) |
| Also tested on | Ubuntu with zsh, GNU coreutils, dash, and bash 5 |

## Why

Shell tutorials tend to show `ls foo`, `grep bar file.txt`, and `mkdir test`. That's
enough to learn the syntax, and not enough to see when you'd actually reach for a
command, or what goes wrong when you do.

Every example here is a small job of work somewhere in the world: a pastelaria in
Lisbon setting up Christmas orders, a geothermal engineer in Reykjavík swapping
turbine folders, a webtoon studio in Seoul renumbering panels. Each feature gets
thirteen of them, ranging from moderate to complex, and no two show the
technique in the same shape. Names are real (no `foo`, `bar`, or `hello world`).

## Running the examples safely

Every script is self-contained and only touches a folder it creates for itself:

```zsh
workdir=$(mktemp -d "${TMPDIR:-/tmp}/pastelaria-belem.XXXXXX")
trap 'rm -rf -- "$workdir"' EXIT
cd -- "$workdir"
```

So it is safe to run any script from anywhere:

```sh
features/01-navigation-and-files/01-lisbon-pastelaria-orders/christmas_orders.zsh
```

Still, read a script before running it. That is a good habit with any script from
the internet, and here reading it is the lesson. Some more habits that help:

- `zsh -n script.zsh` checks syntax without running commands. (It still tries
  `$(< file)` reads, so it may complain about files that only exist at run time.)
  For bash scripts that use `extglob`, check with `bash -O extglob -n`: in `-n`
  mode the script's own `shopt -s extglob` never runs.
- `zsh -x script.zsh` (or `bash -x`, `sh -x`) prints each command as it runs.
- Fixtures live in each example's `fixtures/` folder and are *copied* into the temp
  folder; the scripts never modify the repository.
- Scripts use `set -o errexit -o nounset -o pipefail` (`set -eu` in POSIX `sh`), so
  they stop at the first failure instead of carrying on in the wrong folder.
- Anything that deletes (`rm -r`) is guarded, and only ever points inside `$workdir`.
- Expected output is recorded with `LC_ALL=C`. With another locale, mixed-case
  file names may list in a different order.

## zsh first, with notes on bash and BSD vs GNU

macOS has used zsh as the default login shell since Catalina (10.15), so the
examples are written for zsh unless a slot says otherwise. A few slots are written
in bash or POSIX `sh` on purpose, to show where the shells differ.

- **bash on macOS is 3.2** (from 2007, for licensing reasons). It has no `globstar`
  (`**`), no associative arrays, and no `mapfile`. Homebrew's `bash` is current.
- **`/bin/sh`** is bash-in-POSIX-mode on macOS and `dash` on Ubuntu. Scripts with a
  `#!/bin/sh` line stick to POSIX features so both work.
- **BSD vs GNU tools.** macOS ships BSD `ls`, `cp`, `stat`, `sed`, `date`, `find`,
  `wc`, and friends; Linux ships GNU coreutils. Most flags agree. Where they don't,
  the example picks the portable form or detects the flavor, and its README says
  so. Examples: `stat -f %z` vs `stat -c %s`, `cp -R src/` copying contents vs the
  folder, `wc -l` padding its count, `sed -i ''` vs `sed -i`, `date -v-1d` vs
  `date -d yesterday`.
- **macOS-only tools** (`open`, `pbcopy`, `defaults`, `mdfind`, `caffeinate`,
  `launchctl`, `chflags`, `xattr`...) are marked with a `# requires: macos` line.
  The test runner skips those on Linux.

## Features

Each feature folder holds thirteen numbered scenarios. Built features link to
their folder; the rest are planned.

| # | Feature | What it covers | Status |
| --- | --- | --- | --- |
| 01 | [Navigation and files](features/01-navigation-and-files/) | `cd`, `pushd`/`popd`, `cdpath`, named dirs, `ls`, `mkdir`, `cp`, `mv`, `rm`, `ln`, `stat`, `file`, `du` | 13 of 13 built |
| 02 | [Globbing and expansion](features/02-globbing-and-expansion/) | `*` `?` `[...]`, braces, `**/`, qualifiers, extended globs, modifiers, `zmv`, bash `extglob` | 13 of 13 built |
| 03 | [Pipes and redirection](features/03-pipes-and-redirection/) | `|`, `>`, `>>`, `2>&1`, `<`, here-docs, here-strings, `tee`, process substitution, `/dev/null`, multios | 13 of 13 built |
| 04 | [Quoting and parameter expansion](features/04-quoting-and-parameter-expansion/) | single vs double quotes, `$'...'`, `${var:-default}`, `${var#prefix}`, zsh flags `(U)` `(s:,:)` `(j:,:)`, arrays | 13 of 13 built |
| 05 | [Searching text with grep](features/05-searching-text-with-grep/) | `grep -E`, `-i`, `-v`, `-c`, `-o`, `-r`, `-l`, context `-A`/`-B`, `ripgrep` notes, BSD vs GNU `grep -P` | 13 of 13 built |
| 06 | [Finding files with find and xargs](features/06-find-and-xargs/) | `find` tests and actions, `-exec {} +`, `-print0 \| xargs -0`, `-newer`, `-prune`, `fd` notes | 13 of 13 built |
| 07 | [Sorting, counting, and columns](features/07-sorting-counting-and-columns/) | `sort -k -t -n -u`, `uniq -c`, `cut`, `tr`, `paste`, `join`, `comm`, `column -t`, `wc` | 13 of 13 built |
| 08 | [Editing streams with sed and awk](features/08-sed-and-awk/) | `sed` substitution and ranges, `sed -i ''` vs `sed -i`, `awk` fields, `BEGIN`/`END`, arrays, `printf` | 13 of 13 built |
| 09 | [Permissions and ownership](features/09-permissions-and-ownership/) | `chmod` octal and symbolic, `umask`, `chown`, `sudo`, executable bits, `ls -l` decoding, ACLs on macOS | 13 of 13 built |
| 10 | [Processes and jobs](features/10-processes-and-jobs/) | `ps`, `pgrep`/`pkill`, `kill` signals, `&`, `jobs`, `wait`, `nohup`, `trap`, `time`, `lsof`, `caffeinate -w` | 13 of 13 built |
| 11 | [Environment and PATH](features/11-environment-and-path/) | `export`, `env`, `path` array in zsh, `/etc/paths` and `path_helper`, `which`/`whence`/`type`, `.zshenv` vs `.zprofile` | 13 of 13 built |
| 12 | [ssh, scp, and rsync](features/12-ssh-scp-rsync/) | keys and `ssh-agent`, Keychain `UseKeychain`, `~/.ssh/config` hosts, `scp`, `rsync -av --dry-run`, tunnels | 13 of 13 built |
| 13 | [HTTP with curl](features/13-http-with-curl/) | `curl -fsSL`, headers, `-d` and `--json`, `-o`/`-O`, retries, `-w` timing, `jq` for JSON | 13 of 13 built |
| 14 | [Archives and compression](features/14-archives-and-compression/) | `tar -czf`/`-xzf`, `zip`/`unzip`, `ditto -c -k`, `gzip`, `xz`, `shasum -a 256` checksums | 13 of 13 built |
| 15 | Homebrew | `brew install`/`upgrade`/`info`, casks, `Brewfile` and `brew bundle`, `brew services`, `brew doctor` | planned |
| 16 | zsh configuration, aliases, and functions | `.zshrc`, `alias`, suffix and global aliases, functions and `autoload`, `fpath`, options, prompt, `compinit` | planned |
| 17 | macOS desktop bridges | `open` (apps, URLs, `-R`), `pbcopy`/`pbpaste`, `say`, `screencapture`, `osascript`, `sips`, `textutil` | planned (macOS only) |
| 18 | macOS system tools | `defaults`, `mdfind`/`mdls`, `caffeinate`, `pmset`, `launchctl` and launch agents, `diskutil`, `networksetup` | planned (macOS only) |

Planned titles and contents are proposals; see [CONTRIBUTING.md](CONTRIBUTING.md).

## Layout

```
multivitamin.json                   catalog metadata (name, grammar, feature list)
schema/                             JSON Schemas for multivitamin.json, feature.json, lesson.json
features/NN-feature/
  README.md                         the feature's lesson and its thirteen slots
  feature.json                      feature id, title, and `covers` (every api the lessons teach)
  NN-place-scenario/
    script.zsh (or .sh)             the runnable example, with `# region:` markers
    lesson.json                     steps for multivitamin-web: label, api, regions + roles
    expected.txt                    the output the test runner expects
    fixtures/                       small input files, when the scenario needs them
    README.md                       what it teaches, lesson steps, files, how to run
tests/run-examples.zsh              runs every example in a sandbox and diffs its output
tests/check_metadata.py             validates the JSON against schema/ and the markers against the lessons
.github/workflows/test.yml          runs both on pull requests
```

## Highlighting markers

Scripts carry comment markers that the multivitamin build strips before
publishing. Each lesson step in `lesson.json` names regions and gives each one a
role (`primary`, `setup`, or `result`):

```zsh
# region: swap-turbine
# focus: cd turbine-2 turbine-3
cd turbine-2 turbine-3
where "swapped turbine"
# endregion: swap-turbine
```

`# focus:` names the exact text within the region to underline. It must appear on
one of the region's lines. Regions do not nest.

## Tests

```sh
tests/run-examples.zsh            # every example this machine can run
tests/run-examples.zsh globbing   # only paths containing "globbing"
python3 tests/check_metadata.py   # needs: pip install jsonschema
```

The runner gives each script an empty working folder, a fresh `HOME` and `TMPDIR`,
and `LC_ALL=C`, then checks four things: it exits 0, its output matches
`expected.txt`, it left nothing behind in `TMPDIR` or the working folder, and its
own example folder is unchanged. `--update` rewrites `expected.txt` from the
current output; read the diff before committing it.
