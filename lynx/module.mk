# lynx/module.mk
# --------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2014, 2016, 2018, 2020-2023 by Lawrence Velazquez
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


# Shared prerequisites.
lynx lynx-check: lynx/_lynx.cfg lynx/_profile.d/lynx.sh

all: lynx
lynx: FORCE

# Unfortunately "lynx -show_cfg" doesn't seem to ever have a nonzero
# exit status, but its output can be visually inspected to verify that
# lynx is interpreting the configuration file as intended.
check: lynx-check
lynx-check: FORCE
	$(LYNX) -cfg=lynx/_lynx.cfg $(LYNXFLAGS) -show_cfg
	$(SHELLCHECK) $(SHELLCHECKFLAGS) lynx/_profile.d/lynx.sh

clean: lynx-clean
lynx-clean: FORCE
	rm -f lynx/_lynx.cfg

installdirs: lynx-installdirs
lynx-installdirs: sh-installdirs FORCE

install: lynx-install
lynx-install: lynx lynx-installdirs sh-install FORCE
	$(INSTALL_DATA) lynx/_lynx.cfg ~/.lynx.cfg
	$(INSTALL_DATA) lynx/_profile.d/lynx.sh ~/.profile.d/

uninstall: lynx-uninstall
lynx-uninstall: FORCE
	rm -f ~/.lynx.cfg ~/.profile.d/lynx.sh
