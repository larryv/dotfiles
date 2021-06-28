# sh/_profile.d/functions.sh
# --------------------------
#
# Written in 2021 by Lawrence Velázquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


# Returns with an exit status of zero if the given argument is a valid
# name (see POSIX.1-2017 XBD 3.235 [1]) and nonzero otherwise.
is_name() (
    LC_ALL=C
    case $1 in
        '' | *[![:alnum:]_]* | [[:digit:]]*) return 1 ;;
    esac
)

# Given a colon-delimited list and one or more literal search terms,
# prints the list with any matching elements moved to the front. The
# "sort" is stable.
promote() (
    [ "$#" -ge 1 ] || return
    origpath=$1
    shift

    # Remove trailing colons to work around IFS variations [2][3].
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

# Given the names of one or more shell variables, restores their state
# as saved by a preceding call to save_vars. The caller should reserve
# variables of the form `__VAR__orig` for the use of this function and
# save_vars.
restore_vars() {
    for arg
    do
        is_name "$arg" || continue
        if eval '[ -n "${__'"$arg"'__orig+set}" ]'; then
            eval "$arg=\$__${arg}__orig"
            unset "__${arg}__orig"
        else
            unset "$arg"
        fi
    done
    unset arg
}

# Given the names of one or more shell variables, saves their values for
# restoration by a subsequent call to restore_vars. The caller should
# reserve variables of the form `__VAR__orig` for the use of this
# function and restore_vars.
save_vars() {
    for arg
    do
        is_name "$arg" || continue
        if eval '[ -n "${'"$arg"'+set}" ]'; then
            eval "__${arg}__orig=\$$arg"
        else
            unset "__${arg}__orig"
        fi
    done
    unset arg
}

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
    unset -f is_name promote restore_vars save_vars xargs2
    unset -f unset_sh_helper_functions
}


# References
#
#  1. https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_235
#  2. https://www.in-ulm.de/~mascheck/various/ifs/
#  3. https://lists.gnu.org/archive/html/bug-bash/2009-03/msg00137.html
