# Bash script performance profiling

If you're having issues with the performance of a bash script then here is a
simple way to profile the performance of your script.

If you have GNU date (or another version that can output nanoseconds), do this
at the beginning of where you would like to start profiling in any bash script:

```bash
PS4='+ $(date "+%s.%N")\011 '
exec 3>&2 2>/tmp/bashstart.$$.log
set -x
```

and add

```bash
set +x
exec 2>&3 3>&-
```

at the end of script or section. The `\011` is an octal tab character.

You should get a trace log in `/tmp/bashstart.PID.log` that shows the
seconds.nanoseconds timestamp of each command that was executed. The difference
from one time to the next is the amount of time that the intervening step took.

As you narrow things down, you can move `set -x` later and `set +x` earlier (or
bracket several sections of interest selectively).
