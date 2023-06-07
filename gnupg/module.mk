# gnupg/module.mk
# ---------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2016, 2018, 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
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
gnupg gnupg-check: \
	gnupg/_gnupg/dirmngr.conf \
	gnupg/_gnupg/gpg.conf \
	gnupg/_profile.d/gnupg.sh

all: gnupg
gnupg: FORCE

check: gnupg-check
gnupg-check: FORCE
	$(GPG) --options gnupg/_gnupg/dirmngr.conf $(GPGFLAGS) --gpgconf-test
	$(GPG) --options gnupg/_gnupg/gpg.conf $(GPGFLAGS) --gpgconf-test
	$(SHELLCHECK) $(SHELLCHECKFLAGS) gnupg/_profile.d/gnupg.sh

# Set restrictive permissions on the configuration as GnuPG requires.
# Use chmod(1) on directories instead of `$(INSTALL) -d -m` because my
# bundled install-sh (version 2018-03-11.20) doesn't update permissions
# on preexisting directories.

installdirs: gnupg-installdirs
gnupg-installdirs: sh-installdirs FORCE
	$(INSTALL) -d ~/.gnupg/
	chmod 700 ~/.gnupg/

install: gnupg-install
gnupg-install: gnupg gnupg-installdirs sh-install FORCE
	$(INSTALL) -m 600 \
    gnupg/_gnupg/dirmngr.conf \
    gnupg/_gnupg/gpg.conf \
    ~/.gnupg/
	$(INSTALL_DATA) gnupg/_profile.d/gnupg.sh ~/.profile.d/

uninstall: gnupg-uninstall
gnupg-uninstall: FORCE
	rm -f ~/.gnupg/dirmngr.conf ~/.gnupg/gpg.conf ~/.profile.d/gnupg.sh
