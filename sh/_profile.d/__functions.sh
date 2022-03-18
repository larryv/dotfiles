# sh/_profile.d/__functions.sh
# ----------------------------
#
# Written in 2021-2022 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


case $sourced_scripts in
    *' .profile.d/_functions.sh '*) return 0 ;;
esac


# Given a colon-delimited list and one or more literal search terms,
# sets REPLY to the list with any matching elements moved to the front.
# The rearrangement is stable.
promote() {
    if [ "$#" -lt 2 ]; then
        REPLY=$1
        return
    fi
    REPLY=

    # Turn the colon-delimited list into a colon-terminated one, making
    # it unnecessary to treat the final element as a special case.
    xs=$1:
    shift

    unset matched unmatched
    while [ -n "$xs" ]; do
        x=${xs%%:*}
        xs=${xs#*:}
        for arg do
            [ "$x" = "$arg" ] && matched=${matched}${matched+:}${x} && break
        done || unmatched=${unmatched}${unmatched+:}${x}
    done

    REPLY=${matched}${matched+${unmatched+:}}${unmatched}
    unset arg matched unmatched x xs
}


unset_sh_helper_functions() {
    unset -f promote
    unset -f unset_sh_helper_functions
}


sourced_scripts="$sourced_scripts .profile.d/_functions.sh "
