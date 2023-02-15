# java/module.mk
# --------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2018, 2020-2022 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


all: java
java: java/_profile.d/java.sh FORCE

installdirs: java-installdirs
java-installdirs: sh-installdirs FORCE

install: java-install
java-install: java java-installdirs sh-install FORCE
	$(INSTALL_DATA) java/_profile.d/java.sh ~/.profile.d/

uninstall: java-uninstall
java-uninstall: FORCE
	rm -f ~/.profile.d/java.sh
