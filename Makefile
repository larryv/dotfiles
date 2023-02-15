# Makefile
# --------
#
# Written in 2014, 2016-2018, 2020-2023 by Lawrence Velazquez
# <vq@larryv.me>.
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


# Minimize differences between make implementations [1][2][3].
.POSIX:
.SUFFIXES:
.SUFFIXES: .m4
SHELL = /bin/sh

# Allow overriding of utilities [4].
INSTALL = ./install-sh
INSTALL_DATA = $(INSTALL) -m 644
M4 = m4

# Imitate .PHONY portably [5].  List "all" first to make it the default.
all clean maintainer-clean installdirs install uninstall: FORCE
FORCE:

# These subdirectories and their submakefiles constitute "modules",
# describing slices of the final directory tree; these are combined
# during installation.  Beyond rules for updating files, modules define
# their own convenience rules (e.g., `make sh-install`) and make them
# prerequisites of the global rules (e.g., `make install`).
include git/module.mk
include gnupg/module.mk
include java/module.mk
include lynx/module.mk
include macports/module.mk
include mercurial/module.mk
include sh/module.mk
include terminfo/module.mk
include tmux/module.mk
include zsh/module.mk

# Process M4 templates.
.m4:
	$(M4) $< >$@ || { rc=$$?; rm -f $@ && exit "$$rc"; }


# References
#
# 1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
# 2. https://www.gnu.org/software/make/manual/html_node/Special-Targets
# 3. https://www.gnu.org/software/make/manual/html_node/Makefile-Basics
# 4. https://www.gnu.org/software/make/manual/html_node/Command-Variables
# 5. https://www.gnu.org/software/make/manual/html_node/Force-Targets
