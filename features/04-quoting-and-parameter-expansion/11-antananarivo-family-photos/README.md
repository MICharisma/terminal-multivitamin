# Quoting and parameter expansion · 11 · Antananarivo family photo archive, quoting the filenames

A family in Antananarivo is sorting holiday photos whose names hold spaces, apostrophes, parentheses, and a literal `$`. `${(q)name}` quotes each name the way zsh would type it; a plan file of quoted lines is unquoted with `(Q)` and spaces become underscores for the web album.

**What it teaches**

- `${(q)name}` quotes a value the way zsh would type it back in: spaces, quotes, and `$` become safe
- `${(qq)name}` always wraps in single quotes; `${(qqq)name}` always wraps in double quotes
- `${name// /_}` replaces every space; `${(Q)quoted}` undoes one layer of quoting, so a plan file of quoted names becomes real names again
- `"${(@q)photos}"` quotes each array element, ready to paste into a script or a `print -l`

**Lesson steps**

1. Quote each filename the zsh way (`${(q)name}`)
2. Force single or double quotes with qq and qqq (`${(qq)name}`)
3. Write a plan of quoted names (`"${(@q)array}"`)
4. Unquote and replace spaces for the web album (`${(Q)name}`)

**Files**

| File | Role |
| --- | --- |
| [`quote_filenames.zsh`](quote_filenames.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/04-quoting-and-parameter-expansion/11-antananarivo-family-photos/quote_filenames.zsh
tests/run-examples.zsh 11-antananarivo-family-photos
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
