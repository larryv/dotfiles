# sh/_profile.d/__functions.sh
# ----------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2021-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


case $sourced_scripts in
    *' .profile.d/_functions.sh '*)
        return 0
        ;;
esac


# Given a colon-delimited list and a series of search terms, partitions
# the list's elements based on whether they appear in the series.
#
#     partition [input_list [search_term...]]
#
# The PARTITION_MATCHED and PARTITION_UNMATCHED variables are set to
# colon-delimited lists comprising input elements that are and are not
# equal to any search term (by string comparison), respectively.  The
# partition is stable -- i.e., relative ordering is preserved within
# each new list.  If no input element is equal to any search term, then
# PARTITION_MATCHED is unset; if every element is equal to a term, then
# PARTITION_UNMATCHED is unset.
#
# If only the input list argument is provided, then PARTITION_UNMATCHED
# is set to its value, and PARTITION_MATCHED is unset.  If no arguments
# are provided at all, then both PARTITION_* variables are unset.  If
# the exit status is not zero, then the PARTITION_* variables should not
# be used because they are not guaranteed to be in any particular state.
#
# A zero-length value for any "colon-delimited list" parameter denotes
# a list comprising a single zero-length element, not a list of zero
# elements.

partition() {
    unset PARTITION_MATCHED PARTITION_UNMATCHED

    if [ "$#" -lt 1 ]; then
        return 0
    fi

    # Turn the colon-delimited list into a colon-terminated one, making
    # it unnecessary to treat the final element as a special case.
    xs=$1:
    shift

    while [ -n "$xs" ]; do
        x=${xs%%:*}
        xs=${xs#*:}

        for arg
        do
            if [ "$arg" = "$x" ]; then
                PARTITION_MATCHED=${PARTITION_MATCHED+$PARTITION_MATCHED:}$x
                continue 2
            fi
        done

        PARTITION_UNMATCHED=${PARTITION_UNMATCHED+$PARTITION_UNMATCHED:}$x
    done

    unset arg x xs
}


# Given a colon-delimited list and a series of search terms, moves
# elements to the front of the list if they appear in the series.
#
#     promote [input_list [search_term...]]
#
# The REPLY variable is set to a colon-delimited list comprising the
# elements of the input list, rearranged so that all elements that are
# equal to any search term (by string comparison) precede all elements
# that are not equal to any search term.  The rearrangement is stable --
# i.e., relative ordering is preserved within the new prefix and suffix.
#
# If only the input list argument is provided, then REPLY is set to its
# value.  If no arguments are provided at all, then REPLY is unset.  If
# the exit status is not zero, then REPLY should not be used because it
# is not guaranteed to be in any particular state.

promote() {
    partition "$@" || return

    case ${PARTITION_MATCHED+m}${PARTITION_UNMATCHED+u} in
        mu) REPLY=$PARTITION_MATCHED:$PARTITION_UNMATCHED ;;
        u) REPLY=$PARTITION_UNMATCHED ;;
        m) REPLY=$PARTITION_MATCHED ;;
        '') unset REPLY ;;
    esac

    unset PARTITION_MATCHED PARTITION_UNMATCHED
}


unset_sh_helper_functions() {
    unset -f partition promote
    unset -f unset_sh_helper_functions
}


sourced_scripts="$sourced_scripts .profile.d/_functions.sh "
