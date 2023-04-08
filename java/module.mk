# java/module.mk
# --------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2018, 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author has dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


# Shared prerequisites.
java java-check: java/_profile.d/java.sh

all: java
java: FORCE

check: java-check
java-check: FORCE
	$(SHELLCHECK) $(SHELLCHECKFLAGS) java/_profile.d/java.sh

installdirs: java-installdirs
java-installdirs: sh-installdirs FORCE

install: java-install
java-install: java java-installdirs sh-install FORCE
	$(INSTALL_DATA) java/_profile.d/java.sh ~/.profile.d/

uninstall: java-uninstall
java-uninstall: FORCE
	rm -f ~/.profile.d/java.sh
