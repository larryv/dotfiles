# git/module.mk
# -------------
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
git git-check: git/_gitconfig

all: git
git: git/_config/git/ignore FORCE

# TODO: Look into concocting a dummy command to test the ignore file.
check: git-check
git-check: FORCE
	$(GIT) --no-pager config --file git/_gitconfig --list

clean: git-clean
git-clean: FORCE
	rm -f git/_gitconfig

installdirs: git-installdirs
git-installdirs: FORCE
	$(INSTALL) -d ~/.config/git/

install: git-install
git-install: git git-installdirs FORCE
	$(INSTALL_DATA) git/_config/git/ignore ~/.config/git/
	$(INSTALL_DATA) git/_gitconfig ~/.gitconfig

uninstall: git-uninstall
git-uninstall: FORCE
	rm -f ~/.config/git/ignore ~/.gitconfig
