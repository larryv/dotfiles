# terminfo/module.mk
# ------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


# This module is temporarily being skipped by the "global" targets (all,
# install, installdirs, and uninstall) because it doesn't work.
#
# When TERM is set to "nsterm-build400" and my update_terminal_cwd zsh
# function is active, Apple Terminal appears to restore old values of
# the current working directory/document when certain programs are run.
# This can be seen by starting a new terminal, running and quitting
# less(1), using cd(1) to switch to another directory, and running
# less(1) again.  At this point Terminal's current working directory is
# not the new directory but the one in which less(1) was run initially.
# This also occurs with vim(1), nano(1), and no doubt other software,
# but it does NOT occur when using less(1) via `git diff`.
#
# I think this has something to do with the alternate screen, but that's
# just a hunch, and I have not yet attempted to look into it.

#all: terminfo
terminfo: terminfo/_profile.d/terminfo.sh FORCE

#installdirs: terminfo-installdirs
terminfo-installdirs: sh-installdirs FORCE

#install: terminfo-install
terminfo-install: sh-install terminfo terminfo-installdirs FORCE
	$(INSTALL_DATA) terminfo/_profile.d/terminfo.sh ~/.profile.d/

#uninstall: terminfo-uninstall
terminfo-uninstall: FORCE
	rm -f ~/.profile.d/terminfo.sh
