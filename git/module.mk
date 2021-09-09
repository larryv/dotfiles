# git/module.mk
# -------------
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


all: git
git: FORCE git/_config/git/ignore git/_gitconfig

clean: git-clean
git-clean: FORCE
	rm -f git/_gitconfig

installdirs: git-installdirs
git-installdirs: FORCE
	$(INSTALL) -d ~/.config/git/

install: git-install
git-install: FORCE git git-installdirs
	$(INSTALL_DATA) git/_config/git/ignore ~/.config/git/
	$(INSTALL_DATA) git/_gitconfig ~/.gitconfig

uninstall: git-uninstall
git-uninstall: FORCE
	rm -f ~/.config/git/ignore ~/.gitconfig
