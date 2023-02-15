# macports/module.mk
# ------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2016, 2018, 2020-2022 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


all: macports
macports: \
    macports/_profile.d/macports.sh \
    macports/_zsh/zshenv.d/macports.zsh \
    FORCE

installdirs: macports-installdirs
macports-installdirs: sh-installdirs zsh-installdirs FORCE

install: macports-install
macports-install: macports macports-installdirs sh-install zsh-install FORCE
	$(INSTALL_DATA) macports/_profile.d/macports.sh ~/.profile.d/
	if grep /usr/libexec/path_helper /etc/zshenv >/dev/null 2>&1; then \
    $(INSTALL_DATA) \
        macports/_zsh/zshenv.d/macports.zsh \
        ~/.zsh/zshenv.d/; \
fi

uninstall: macports-uninstall
macports-uninstall: FORCE
	rm -f ~/.profile.d/macports.sh ~/.zsh/zshenv.d/macports.zsh
