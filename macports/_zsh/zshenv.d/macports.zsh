# macports/_zsh/zshenv.d/macports.zsh
# -----------------------------------
#
# Written in 2014-2016, 2018, 2020-2022 by Lawrence Velázquez
# <vq@larryv.me>.
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
    *' .zsh/zshenv.d/macports.zsh '*) return 0 ;;
esac

# On OS X 10.10 Yosemite and earlier, /etc/zshenv unconditionally
# redefines the command path using path_helper(8), even in non-login
# shells (e.g., executing a script).  This puts the directories from
# /etc/paths back in front.  In non-login shells, reclaim that position
# for MacPorts directories.  (Login shells do this in .zprofile.)

if [[ ! -o LOGIN ]]; then
    # >= 4.3.7: () { emulate -L sh; . ~/.profile.d/macports.sh; }
    # >= 4.3.10: emulate sh -c '. ~/.profile.d/macports.sh'
    fix_macports_path() {
        emulate -L sh
        . ~/.profile.d/macports.sh && unset -f -- "$0"

        # https://www.zsh.org/mla/users/2008/msg00785.html (users/13169)
        # < 4.3.7: Options are restored at function exit but emulation
        # mode is not.  Explicitly restore zsh mode, or things get weird
        # later.
        emulate -L zsh
    }
    fix_macports_path
fi

sourced_scripts="$sourced_scripts .zsh/zshenv.d/macports.zsh "
