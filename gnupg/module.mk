all: gnupg
gnupg: FORCE \
    gnupg/_gnupg/dirmngr.conf \
    gnupg/_gnupg/gpg.conf \
    gnupg/_profile.d/gnupg.sh

# Set restrictive permissions on the configuration as GnuPG requires. Use
# chmod(1) on directories instead of `$(INSTALL) -d -m` because my bundled
# install-sh (version 2018-03-11.20) doesn't update permissions on preexisting
# directories.

installdirs: gnupg-installdirs
gnupg-installdirs: FORCE
	$(INSTALL) -d ~/.gnupg/ ~/.profile.d/
	chmod 700 ~/.gnupg/

install: gnupg-install
gnupg-install: FORCE gnupg gnupg-installdirs
	$(INSTALL) -m 600 \
    gnupg/_gnupg/dirmngr.conf gnupg/_gnupg/gpg.conf ~/.gnupg/
	$(INSTALL_DATA) gnupg/_profile.d/gnupg.sh ~/.profile.d/

uninstall: gnupg-uninstall
gnupg-uninstall: FORCE
	rm -f ~/.gnupg/dirmngr.conf ~/.gnupg/gpg.conf ~/.profile.d/gnupg.sh
