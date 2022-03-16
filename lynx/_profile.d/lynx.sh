# lynx/_profile.d/lynx.sh
# -----------------------
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
    *' .profile.d/lynx.sh '*) return 0 ;;
esac

if [ -z "$LYNX_CFG" ]; then
    export LYNX_CFG="$HOME/.lynx.cfg"
fi

sourced_scripts="$sourced_scripts .profile.d/lynx.sh "
