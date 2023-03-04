# zsh/module.mk
# -------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2016, 2018, 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


all: zsh
zsh: \
    zsh/_zsh/functions/colorpairs \
    zsh/_zsh/functions/emulated_eval \
    zsh/_zsh/functions/update_terminal_cwd \
    zsh/_zshenv \
    zsh/_zsh/_zprofile \
    zsh/_zsh/_zshrc \
    zsh/_zsh/_zlogin \
    FORCE

installdirs: zsh-installdirs
zsh-installdirs: FORCE
	$(INSTALL) -d \
    ~/.zsh/functions/ \
    ~/.zsh/zshenv.d/ \
    ~/.zsh/zprofile.d/ \
    ~/.zsh/zshrc.d/ \
    ~/.zsh/zlogin.d/

# ~/.zsh/zprofile sources ~/.profile.
install: zsh-install
zsh-install: sh-install zsh zsh-installdirs FORCE
	$(INSTALL_DATA) \
    zsh/_zsh/functions/colorpairs \
    zsh/_zsh/functions/emulated_eval \
    zsh/_zsh/functions/update_terminal_cwd \
    ~/.zsh/functions/
	$(INSTALL_DATA) zsh/_zshenv ~/.zshenv
	$(INSTALL_DATA) zsh/_zsh/_zprofile ~/.zsh/.zprofile
	$(INSTALL_DATA) zsh/_zsh/_zshrc ~/.zsh/.zshrc
	$(INSTALL_DATA) zsh/_zsh/_zlogin ~/.zsh/.zlogin
	ln -fs ../.zshenv ~/.zsh/.zshenv
	ln -fs ../.zshenv ~/.zsh/zshenv
	ln -fs .zprofile ~/.zsh/zprofile
	ln -fs .zshrc ~/.zsh/zshrc
	ln -fs .zlogin ~/.zsh/zlogin

uninstall: zsh-uninstall
zsh-uninstall: FORCE
	rm -f \
    ~/.zsh/functions/colorpairs \
    ~/.zsh/functions/emulated_eval \
    ~/.zsh/functions/update_terminal_cwd \
    ~/.zsh/zshenv ~/.zsh/.zshenv ~/.zshenv \
    ~/.zsh/zprofile ~/.zsh/.zprofile \
    ~/.zsh/zshrc ~/.zsh/.zshrc \
    ~/.zsh/zlogin ~/.zsh/.zlogin
