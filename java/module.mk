# java/module.mk
# --------------
#
# Written in 2018, 2020-2021 by Lawrence Velázquez <vq@larryv.me>.
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


all: java
java: FORCE java/_profile.d/java.sh

installdirs: java-installdirs
java-installdirs: FORCE sh-installdirs

install: java-install
java-install: FORCE java java-installdirs sh-install
	$(INSTALL_DATA) java/_profile.d/java.sh ~/.profile.d/

uninstall: java-uninstall
java-uninstall: FORCE
	rm -f ~/.profile.d/java.sh
