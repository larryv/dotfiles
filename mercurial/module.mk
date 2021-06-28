# mercurial/module.mk
# -------------------
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


all: mercurial
mercurial: FORCE mercurial/_hgrc

install: mercurial-install
mercurial-install: FORCE mercurial
	$(INSTALL_DATA) mercurial/_hgrc ~/.hgrc

uninstall: mercurial-uninstall
mercurial-uninstall: FORCE
	rm -f ~/.hgrc
