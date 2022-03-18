# gnupg/_profile.d/gnupg.sh
# -------------------------
#
# Written in 2016, 2018, 2020-2022 by Lawrence Velazquez <vq@larryv.me>.
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
    *' .profile.d/gnupg.sh '*) return 0 ;;
esac

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html
if [ -z "$GPG_TTY" ]; then
    if gpg_tty=$(tty); then
        export GPG_TTY="$gpg_tty"
    fi
    unset gpg_tty
fi

sourced_scripts="$sourced_scripts .profile.d/gnupg.sh "
