# zsh/module.mk
# -------------
#
# Written in 2016, 2018, 2020-2021 by Lawrence Velázquez <vq@larryv.me>.
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


all: zsh
zsh: FORCE \
    zsh/_zsh/functions/update_terminal_cwd \
    zsh/_zsh/zlogin \
    zsh/_zsh/zprofile \
    zsh/_zsh/zshenv \
    zsh/_zsh/zshrc

installdirs: zsh-installdirs
zsh-installdirs: FORCE
	$(INSTALL) -d ~/.zsh/functions/ ~/.zsh/zlogin.d/ ~/.zsh/zprofile.d/ \
    ~/.zsh/zshenv.d/ ~/.zsh/zshrc.d/

# ~/.zsh/zprofile sources ~/.profile.
install: zsh-install
zsh-install: FORCE sh-install zsh zsh-installdirs
	$(INSTALL_DATA) \
    zsh/_zsh/functions/update_terminal_cwd ~/.zsh/functions/
	$(INSTALL_DATA) \
    zsh/_zsh/zlogin zsh/_zsh/zprofile zsh/_zsh/zshenv zsh/_zsh/zshrc ~/.zsh/
	ln -fs .zsh/zshenv ~/.zshenv
	ln -fs zshenv ~/.zsh/.zshenv
	ln -fs zprofile ~/.zsh/.zprofile
	ln -fs zshrc ~/.zsh/.zshrc
	ln -fs zlogin ~/.zsh/.zlogin

uninstall: zsh-uninstall
zsh-uninstall: FORCE
	rm -f ~/.zsh/functions/update_terminal_cwd ~/.zsh/zlogin \
    ~/.zsh/zprofile ~/.zsh/zshenv ~/.zsh/zshrc ~/.zsh/.zlogin \
    ~/.zsh/.zprofile ~/.zshenv ~/.zsh/.zshrc
