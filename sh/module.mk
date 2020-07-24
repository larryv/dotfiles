all: sh
sh: FORCE sh/_profile

installdirs: sh-installdirs
sh-installdirs: FORCE
	$(INSTALL) -d ~/.profile.d/

install: sh-install
sh-install: FORCE sh sh-installdirs
	$(INSTALL_DATA) sh/_profile ~/.profile

uninstall: sh-uninstall
sh-uninstall: FORCE
	rm -f ~/.profile
