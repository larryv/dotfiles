# lynx/module.mk
# --------------
#
# Written in 2014, 2016, 2018, 2020 by Lawrence Velázquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


all: lynx
lynx: FORCE lynx/_lynx.cfg lynx/_profile.d/lynx.sh

clean: lynx-clean
lynx-clean: FORCE
	rm -f lynx/_lynx.cfg

installdirs: lynx-installdirs
lynx-installdirs: FORCE sh-installdirs

install: lynx-install
lynx-install: FORCE lynx lynx-installdirs sh-install
	$(INSTALL_DATA) lynx/_lynx.cfg ~/.lynx.cfg
	$(INSTALL_DATA) lynx/_profile.d/lynx.sh ~/.profile.d/

uninstall: lynx-uninstall
lynx-uninstall: FORCE
	rm -f ~/.lynx.cfg ~/.profile.d/lynx.sh
