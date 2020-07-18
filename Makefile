# Minimize differences between make implementations [1][2][3].
.POSIX:
.SUFFIXES:
.SUFFIXES: .m4
SHELL = /bin/sh

# Allow overriding of utilities [4].
INSTALL = ./install-sh
INSTALL_DATA = $(INSTALL) -C -m 644
M4 = m4

# Imitate .PHONY portably [5]. List "all" first to make it the default target.
all clean maintainer-clean installdirs install uninstall: FORCE
FORCE:

# Child directories listed here are considered "modules", containing "slices"
# of the final directory tree; these are "layered" during installation. Beyond
# rules for updating files, modules define their own convenience rules (e.g.,
# "make sh-install") and make them prerequisites of the analogous global rules
# (e.g., "make install").
include git/module.mk
include gnupg/module.mk
include java/module.mk
include lynx/module.mk
include macports/module.mk
include mercurial/module.mk
include sh/module.mk
include tmux/module.mk
include zsh/module.mk

# Process M4 templates.
.m4:
	$(M4) $< >$@ \
    || { rc=$$?; rm -f $@ && exit $$rc; }


# References:
#
# 1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html
# 2. https://www.gnu.org/software/make/manual/html_node/Special-Targets
# 3. https://www.gnu.org/software/make/manual/html_node/Makefile-Basics
# 4. https://www.gnu.org/software/make/manual/html_node/Command-Variables
# 5. https://www.gnu.org/software/make/manual/html_node/Force-Targets
