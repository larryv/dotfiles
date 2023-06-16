# gnupg/_profile.d/gnupg.sh
# -------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2016, 2018, 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
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
	*' .profile.d/gnupg.sh '*)
		return 0
		;;
	*)
		srcd="$srcd .profile.d/gnupg.sh " || return
		;;
esac

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html
if [ ! "${GPG_TTY+y}" ]
then
	# TTY is a zsh thing, but check for it here because, in theory,
	# it could be set by other shells or the terminal emulator.
	if GPG_TTY=${TTY:-$(tty)}
	then
		export GPG_TTY
	else
		unset -v GPG_TTY
	fi
fi
