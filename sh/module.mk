all: sh
sh: FORCE sh/_profile

install: sh-install
sh-install: FORCE sh
	$(INSTALL_DATA) sh/_profile ~/.profile

uninstall: sh-uninstall
sh-uninstall: FORCE
	rm -f ~/.profile
