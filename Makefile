# Makefile
# --------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2014, 2016-2018, 2020-2023 by Lawrence Velazquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author has dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


# Reduce differences between make(1) implementations [1][2][3][4].
.POSIX:
.SUFFIXES:
.SUFFIXES: .m4
SHELL = /bin/sh

# Core utilities [5].  Reduce the number of shells in play by invoking
# install-sh with the same shell that make(1) uses.  Use "./install-sh"
# instead of "install-sh" to preclude inadvertent PATH searches [6][7].
INSTALL = $(SHELL) ./install-sh
INSTALL_DATA = $(INSTALL) -m 644
M4 = m4

# Utilities [5] used by "check" targets only.
GIT = git
GPG = gpg
LYNX = lynx
SHELLCHECK = shellcheck
ZSH = zsh

# Imitate .PHONY portably [8].  List "all" first to make it the default.
all check clean maintainer-clean installdirs install uninstall: FORCE
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

# Process M4 templates.  Portably imitate .DELETE_ON_ERROR [9] because
# m4(1) may fail after the shell creates/truncates the target.
.m4:
	$(M4) $< >$@ || { rc=$$?; rm -f $@ && exit "$$rc"; }


# References
#
# 1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
# 2. https://www.gnu.org/software/make/manual/html_node/Special-Targets
# 3. https://www.gnu.org/software/make/manual/html_node/Makefile-Basics
# 4. https://www.gnu.org/software/autoconf/manual/autoconf-2.71/html_node/The-Make-Macro-SHELL.html
# 5. https://www.gnu.org/software/make/manual/html_node/Command-Variables
# 6. https://www.gnu.org/software/autoconf/manual/autoconf-2.71/html_node/Invoking-the-Shell.html
# 7. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html
# 8. https://www.gnu.org/software/make/manual/html_node/Force-Targets
# 9. https://www.gnu.org/software/make/manual/html_node/Errors.html
