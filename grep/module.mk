# grep/module.mk
# --------------
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


all: grep
grep: grep/_profile.d/grep.sh FORCE

installdirs: grep-installdirs
grep-installdirs: FORCE sh-installdirs

install: grep-install
grep-install: grep grep-installdirs sh-install FORCE
	$(INSTALL_DATA) grep/_profile.d/grep.sh ~/.profile.d/

uninstall: grep-uninstall
grep-uninstall: FORCE
	rm -f ~/.profile.d/grep.sh
