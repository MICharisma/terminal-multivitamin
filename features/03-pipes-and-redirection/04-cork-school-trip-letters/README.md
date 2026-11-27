# Pipes and redirection · 04 · Cork secondary school, Skellig Michael trip letters

A secondary school in Cork takes its Transition Year students to Skellig Michael, and every guardian gets a letter. The roster, the letter, the kit list, and a small reminder script all live in one file as here-docs. Some must expand `$first` and `$(kit_list)`; the reminder script must keep its `$1` literal, so its marker is quoted.

**What it teaches**

- a here-doc (`<<WORD ... WORD`) feeds the lines between the markers to a command's stdin
- an unquoted marker expands `$variables` and `$(commands)` inside; a quoted one (`<<'WORD'`) keeps them literal
- `done <<'ROSTER'` feeds a whole `while read` loop from lines kept in the script
- `<<-WORD` strips leading tabs (not spaces), so the body can be indented inside a function

**Lesson steps**

1. Write a script with a quoted here-doc, keeping $1 literal (`<<'EOF'`)
2. Indent a here-doc with tabs inside a function (`<<-EOF`)
3. Feed the roster loop from a here-doc (`done <<'EOF'`)
4. Write each letter with an expanding here-doc (`<<EOF`)

**Files**

| File | Role |
| --- | --- |
| [`trip_letters.zsh`](trip_letters.zsh) | The runnable script, with `# region:` markers for the lesson steps |
| [`lesson.json`](lesson.json) | Lesson steps for multivitamin-web: label, command, and highlighted regions |
| [`expected.txt`](expected.txt) | The output the test runner expects (with `LC_ALL=C`) |

**Try it**

From the repository root:

```sh
features/03-pipes-and-redirection/04-cork-school-trip-letters/trip_letters.zsh
tests/run-examples.zsh 04-cork-school-trip-letters
```

The script creates its own folder with `mktemp -d`, works only inside it, and deletes it on exit. It runs the same on macOS and Linux.
