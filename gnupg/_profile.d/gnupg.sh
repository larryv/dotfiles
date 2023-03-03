# gnupg/_profile.d/gnupg.sh
# -------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2016, 2018, 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
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
    *' .profile.d/gnupg.sh '*)
        return 0
        ;;
esac

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html
if [ ! "${GPG_TTY+y}" ]; then
    # TTY is a zsh thing, but I check for it here because theoretically
    # another shell, or even the terminal emulator itself, could set it.
    if gpg_tty=${TTY:-$(tty)}; then
        export GPG_TTY="$gpg_tty"
    fi
    unset -v gpg_tty
fi

sourced_scripts="$sourced_scripts .profile.d/gnupg.sh "
