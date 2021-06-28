# tmux/module.mk
# --------------
#
# Written in 2018, 2020 by Lawrence Velázquez <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


all: tmux
tmux: FORCE tmux/_tmux.conf

install: tmux-install
tmux-install: FORCE tmux
	$(INSTALL_DATA) tmux/_tmux.conf ~/.tmux.conf

uninstall: tmux-uninstall
tmux-uninstall: FORCE
	rm -f ~/.tmux.conf
