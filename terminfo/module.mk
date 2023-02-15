# terminfo/module.mk
# ------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


all: terminfo
terminfo: terminfo/_profile.d/terminfo.sh FORCE

installdirs: terminfo-installdirs
terminfo-installdirs: sh-installdirs FORCE

install: terminfo-install
terminfo-install: sh-install terminfo terminfo-installdirs FORCE
	$(INSTALL_DATA) terminfo/_profile.d/terminfo.sh ~/.profile.d/

uninstall: terminfo-uninstall
terminfo-uninstall: FORCE
	rm -f ~/.profile.d/terminfo.sh
