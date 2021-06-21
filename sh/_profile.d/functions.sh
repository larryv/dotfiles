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

unset_sh_helper_functions() {
    unset -f promote xargs2
    unset -f unset_sh_helper_functions
}
