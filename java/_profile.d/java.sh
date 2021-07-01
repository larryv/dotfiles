# java/_profile.d/java.sh
# -----------------------
#
# Written in 2016, 2018-2021 by Lawrence Velázquez <vq@larryv.me>.
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


# On Mac, set JAVA_HOME to the active JVM, if there is one.

if [ -z "$JAVA_HOME" ]; then
    # https://www.etalabs.net/sh_tricks.html, § "Getting non-clobbered output
    # from command substitution"
    if jh=$(/usr/libexec/java_home --failfast 2>/dev/null && echo x); then
        save_vars LC_ALL LC_CTYPE
        LC_ALL= LC_CTYPE=C
        export JAVA_HOME="${jh%??}"
        restore_vars LC_ALL LC_CTYPE
    fi
    unset jh
fi
