#!/usr/bin/env zsh
# Runs every example script in a throwaway sandbox and compares its output
# with the expected.txt beside it.
#
#   tests/run-examples.zsh                  run everything this machine can run
#   tests/run-examples.zsh 02-globbing      only examples whose path contains a filter
#   tests/run-examples.zsh --macos-only     only scripts marked `# requires: macos`
#   tests/run-examples.zsh --update [...]   rewrite expected.txt from the current output
#                                           (read the diff before committing it)
#
# Each script runs with a clean environment (LC_ALL=C, a fresh HOME and TMPDIR,
# and an empty working directory). Besides the output, the runner checks that
# the script cleaned up its temp folder, wrote nothing into the working
# directory, and left its own example folder untouched.
emulate -R zsh
setopt extended_glob pipe_fail no_unset

root=${0:A:h:h}
update=0 macos_only=0
typeset -a filters
for arg in "$@"; do
  case $arg in
    (--update)     update=1 ;;
    (--macos-only) macos_only=1 ;;
    (-h|--help)    sed -n '2,15p' $0; exit 0 ;;
    (*)            filters+=( $arg ) ;;
  esac
done

on_macos=0
[[ $OSTYPE == darwin* ]] && on_macos=1

snapshot() {
  # Names, sizes, and modes of everything in a folder: cheap and enough to notice changes.
  local f size
  for f in $1/**/*(DN); do
    if [[ -d $f ]]; then size=dir; else size=$(( $(wc -c < $f) )); fi
    print -r -- "${f#$1/} $size $(ls -ld -- $f | cut -c1-10)"
  done
}

passed=0 failed=0 skipped=0
typeset -a failures

for example in $root/features/*/*(/); do
  rel=${example#$root/}
  if (( $#filters )); then
    matched=0
    for filter in $filters; [[ $rel == *$filter* ]] && matched=1
    (( matched )) || continue
  fi

  scripts=( $example/*.(zsh|sh|bash)(N.) )
  if (( $#scripts != 1 )); then
    print "not ok - $rel (expected one script, found $#scripts)"
    failures+=( $rel ); (( failed++ )); continue
  fi
  script=$scripts[1]

  needs_macos=0
  grep -q '^# requires: macos' $script && needs_macos=1
  if (( macos_only && ! needs_macos )); then
    continue
  fi
  if (( needs_macos && ! on_macos )); then
    print "ok - $rel # SKIP requires macOS"
    (( skipped++ )); continue
  fi

  sandbox=$(mktemp -d "${TMPDIR:-/tmp}/multivitamin-run.XXXXXX")
  mkdir -p $sandbox/{home,tmp,cwd}
  before=$(snapshot $example)

  ( cd $sandbox/cwd &&
    env -i HOME=$sandbox/home TMPDIR=$sandbox/tmp PATH=$PATH LC_ALL=C TERM=dumb \
      $script ) > $sandbox/stdout 2> $sandbox/stderr
  exit_status=$?

  problems=()
  (( exit_status == 0 )) || problems+=( "exited $exit_status" )
  [[ -z $(ls -A $sandbox/tmp) ]] || problems+=( "left files in TMPDIR: $(ls -A $sandbox/tmp)" )
  [[ -z $(ls -A $sandbox/cwd) ]] || problems+=( "wrote into the working directory: $(ls -A $sandbox/cwd)" )
  [[ $before == "$(snapshot $example)" ]] || problems+=( "changed files in its own example folder" )

  if (( update )) && (( exit_status == 0 )); then
    cp $sandbox/stdout $example/expected.txt
  fi
  if [[ ! -f $example/expected.txt ]]; then
    problems+=( "no expected.txt (run with --update to create it)" )
  elif ! diff -u $example/expected.txt $sandbox/stdout > $sandbox/diff; then
    problems+=( "output differs from expected.txt" )
  fi

  if (( $#problems )); then
    print "not ok - $rel"
    for problem in $problems; print "#   $problem"
    [[ -s $sandbox/diff ]] && sed 's/^/#   /' $sandbox/diff
    [[ -s $sandbox/stderr ]] && { print "#   stderr:"; sed 's/^/#     /' $sandbox/stderr }
    failures+=( $rel ); (( failed++ ))
  else
    print "ok - $rel"
    (( passed++ ))
  fi
  rm -rf -- $sandbox
done

print "\n$passed passed, $failed failed, $skipped skipped"
(( failed == 0 ))
