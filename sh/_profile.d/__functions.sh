# sh/_profile.d/__functions.sh
# ----------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2021-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author has dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


# shellcheck shell=sh


case $srcd in
	*' .profile.d/_functions.sh '*)
		return 0
		;;
	*)
		srcd="$srcd .profile.d/_functions.sh " || return
		;;
esac


# Given a colon-delimited list and a series of search terms, moves
# elements to the back of the list if they appear in the series.
#
#	demote [input_list [search_term...]]
#
# The REPLY variable is set to a colon-delimited list comprising the
# elements of the input list, rearranged so that all elements that are
# equal to any search term (by string comparison) follow all elements
# that are not equal to any search term.  The rearrangement is stable --
# i.e., relative ordering is preserved within the new prefix and suffix.
#
# If only the input list argument is provided, then REPLY is set to its
# value.  If no arguments are provided at all, then REPLY is unset.  If
# the exit status is not zero, then REPLY should not be used because it
# is not guaranteed to be in any particular state.

demote() {
	partition "$@" || return

	case ${MATCHED+m}${UNMATCHED+u} in
		mu) REPLY=$UNMATCHED:$MATCHED ;;
		u) REPLY=$UNMATCHED ;;
		m) REPLY=$MATCHED ;;
		'') unset -v REPLY ;;
	esac || return

	unset -v MATCHED UNMATCHED
}

tmpfuncs="$tmpfuncs demote "


# Given a colon-delimited list and a series of search terms, partitions
# the list's elements based on whether they appear in the series.
#
#	partition [input_list [search_term...]]
#
# The MATCHED and UNMATCHED variables are set to colon-delimited lists
# comprising input elements that are and are not equal to any search
# term (by string comparison), respectively.  The partition is stable --
# i.e., relative ordering is preserved within each new list.  If no
# input element is equal to any search term, then MATCHED is unset; if
# every element is equal to a term, then UNMATCHED is unset.
#
# If only the input list argument is provided, then UNMATCHED is set to
# its value, and MATCHED is unset.  If no arguments are provided at all,
# then both MATCHED and UNMATCHED are unset.  If the exit status is not
# zero, then MATCHED and UNMATCHED should not be used because they are
# not guaranteed to be in any particular state.
#
# A zero-length value for any "colon-delimited list" parameter denotes
# a list comprising a single zero-length element, not a list of zero
# elements.

partition() {
	unset -v MATCHED UNMATCHED || return

	if [ "$#" -lt 1 ]
	then
		return 0
	fi

	# Turn the colon-delimited list into a colon-terminated one, making
	# it unnecessary to treat the final element as a special case.
	xs=$1: || return
	shift

	while [ "$xs" ]; do
		x=${xs%%:*} || return
		xs=${xs#*:}

		for arg
		do
			if [ "$arg" = "$x" ]; then
				MATCHED=${MATCHED+$MATCHED:}$x
				continue 2
			fi
		done || return

		UNMATCHED=${UNMATCHED+$UNMATCHED:}$x
	done

	unset -v arg x xs
}

tmpfuncs="$tmpfuncs partition "


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

	case ${MATCHED+m}${UNMATCHED+u} in
		mu) REPLY=$MATCHED:$UNMATCHED ;;
		u) REPLY=$UNMATCHED ;;
		m) REPLY=$MATCHED ;;
		'') unset -v REPLY ;;
	esac || return

	unset -v MATCHED UNMATCHED
}

tmpfuncs="$tmpfuncs promote "
