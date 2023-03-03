# java/_profile.d/java.sh
# -----------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2016, 2018-2023 by Lawrence Velazquez <vq@larryv.me>.
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
    *' .profile.d/java.sh '*)
        return 0
        ;;
esac

# On Mac, set JAVA_HOME to the active JVM, if there is one.

if [ ! "${JAVA_HOME+y}" ]; then
    # https://www.etalabs.net/sh_tricks.html ("Getting non-clobbered
    # output from command substitution")
    if jh=$(/usr/libexec/java_home --failfast 2>/dev/null && echo .); then
        export JAVA_HOME="${jh%??}"
    fi
    unset -v jh
fi

sourced_scripts="$sourced_scripts .profile.d/java.sh "
