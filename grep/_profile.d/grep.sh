# grep/_profile.d/grep.sh
# -----------------------
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
    *' .profile.d/grep.sh '*) return 0 ;;
esac

if [ -z "$GREP_OPTIONS" ]; then
    export GREP_OPTIONS=--color=auto
fi

sourced_scripts="$sourced_scripts .profile.d/grep.sh "
