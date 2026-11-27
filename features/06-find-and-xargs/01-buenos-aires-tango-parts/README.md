# Finding files with find and xargs · 01 · Buenos Aires tango orchestra, pulling parts for rehearsal

An orquesta típica in Almagro keeps its parts in one folder per tango: PDFs from the arranger, a `contrabajo.PDF` scanned by the copyist, a MuseScore file for the new Libertango, and a `piano-arreglos/` folder of sketches. Before Thursday's rehearsal the librarian pulls every part a musician can open. Case, file type, and `-o` precedence each change what `find` returns.

**What it teaches**

- `find dir -name '*.pdf'` tests the file name only, and case matters
- `-iname` ignores case, so the copyist's `contrabajo.PDF` turns up too
- `-type f` keeps a folder called `piano-arreglos/` out of a list of piano parts
- `-o` binds looser than the implied "and", so `a -o b -print` prints only `b`; `\( a -o b \) -print` prints both
- `find` lists in directory order, not alphabetical order; pipe it to `sort`

**Lesson steps**

1. Find the PDF parts by name (`find -name`)
2. Ignore case to catch the copyist's .PDF (`find -iname`)
3. Keep the piano-arreglos folder out with -type f (`find -type f`)
4. Group the -o tests in parentheses before -print (`find \( a -o b \)`)

**Files**

| File | Role |
| --- | --- |
| [`rehearsal_parts.zsh`](rehearsal_parts.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/06-find-and-xargs/01-buenos-aires-tango-parts/rehearsal_parts.zsh
tests/run-examples.zsh 01-buenos-aires-tango-parts
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
