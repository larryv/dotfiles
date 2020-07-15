# Move MacPorts directories to the beginning of PATH so its software takes
# precedence over the system's. I used to add the directories to PATH in this
# file, but any files sourced earlier could not find MacPorts-installed
# software. Using /etc/paths.d gets the directories into PATH sooner, but they
# are appended after the default entries. (See the path_helper(8) man page for
# details.)

# Given a colon-delimited list and one or more literal search terms, print the
# list with any matching elements moved to the front. The "sort" is stable.
promote() (
    origpath=$1
    shift 2>/dev/null || return

    # https://www.in-ulm.de/~mascheck/various/ifs/
    # https://lists.gnu.org/archive/html/bug-bash/2009-03/msg00137.html
    # Remove trailing colons to work around variations in IFS splitting.
    endcolons=${origpath##*[!:]}
    origpath=${origpath%"$endcolons"}

    set -f
    IFS=:
    unset arg head tail
    for x in ${origpath:-''}; do
        for arg do
            [ "$x" = "$arg" ] && head=${head}${head+:}${x} && break
        done && [ -n "${arg+set}" ] || tail=${tail}${tail+:}${x}
    done

    # Handle the trailing empty elements we removed earlier.
    if [ -n "$endcolons" ]; then
        for arg do
            [ -z "$arg" ] && head=${head}${head+:}${endcolons%?} && break
        done && [ -n "${arg+set}" ] || tail=${tail}${tail+:}${endcolons%?}
    fi

    printf '%s%s%s' "$head" "${head+${tail+:}}" "$tail"
)

# A minimalist version of xargs(1) that can invoke functions and builtins. No
# options are accepted. Arguments read from standard input are separated by
# newlines; no other characters are considered special. The utility is invoked
# once, with no attempt to limit the length of the constructed command line.
xargs2() {
    [ $# -gt 0 ] || set -- echo
    while IFS= read -r line || [ -n "$line" ]; do
        set -- "$@" "$line"
    done
    unset line
    "$@"
}

# MacPorts does not provide this file; I create it myself. It usually contains
# "/opt/local/bin" and "/opt/local/sbin". As per path_helper(8), treat all
# newlines as delimiters and ignore blank lines.

mp_paths=/etc/paths.d/macports
if [ -n "${PATH+set}" ] && [ -f "$mp_paths" ]; then
    PATH=$(sed '/./!d' "$mp_paths" | xargs2 promote "$PATH"; echo x)
    PATH=${PATH%?}
fi

unset -f promote xargs2
unset mp_paths
