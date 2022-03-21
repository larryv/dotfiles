# sh/module.mk
# ------------
#
# Written in 2020-2022 by Lawrence Velazquez <vq@larryv.me>.
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


all: sh
sh: sh/_profile sh/_profile.d/__functions.sh FORCE

installdirs: sh-installdirs
sh-installdirs: FORCE
	$(INSTALL) -d ~/.profile.d/

install: sh-install
sh-install: sh sh-installdirs FORCE
	$(INSTALL_DATA) sh/_profile ~/.profile
	$(INSTALL_DATA) sh/_profile.d/__functions.sh ~/.profile.d/_functions.sh

uninstall: sh-uninstall
sh-uninstall: FORCE
	rm -f ~/.profile ~/.profile.d/_functions.sh
