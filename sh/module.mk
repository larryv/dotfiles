all: sh
sh: FORCE sh/_profile sh/_profile.d/functions.sh

installdirs: sh-installdirs
sh-installdirs: FORCE
	$(INSTALL) -d ~/.profile.d/

install: sh-install
sh-install: FORCE sh sh-installdirs
	$(INSTALL_DATA) sh/_profile ~/.profile
	$(INSTALL_DATA) sh/_profile.d/functions.sh ~/.profile.d/

uninstall: sh-uninstall
sh-uninstall: FORCE
	rm -f ~/.profile ~/.profile.d/functions.sh
