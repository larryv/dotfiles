# macports/_zsh/zshenv.d/macports.zsh
# -----------------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2014-2016, 2018, 2020-2023 by Lawrence Velazquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author has dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


if [[ $already_sourced == *' .zsh/zshenv.d/macports.zsh '* ]]; then
	return 0
else
	already_sourced+=' .zsh/zshenv.d/macports.zsh '
fi

# On OS X 10.10 Yosemite and earlier, /etc/zshenv unconditionally
# redefines the command path using path_helper(8), even in non-login
# shells (e.g., executing a script).  This puts the directories from
# /etc/paths back in front.  In non-login shells, reclaim that position
# for MacPorts directories.  (Login shells do this via .zprofile.)

if [[ ! -o LOGIN ]]; then
	autoload -Uz emulated_eval
	functions_to_unset+=' emulated_eval '
	emulated_eval sh '. ~/.profile.d/macports.sh'
fi
