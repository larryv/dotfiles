# mercurial/module.mk
# -------------------
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


all: mercurial
mercurial: mercurial/_hgrc FORCE

# TODO: Look into validating the configuration file.

install: mercurial-install
mercurial-install: mercurial FORCE
	$(INSTALL_DATA) mercurial/_hgrc ~/.hgrc

uninstall: mercurial-uninstall
mercurial-uninstall: FORCE
	rm -f ~/.hgrc
