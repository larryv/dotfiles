all: lynx
lynx: FORCE lynx/_lynx.cfg lynx/_profile.d/lynx.sh

clean: lynx-clean
lynx-clean: FORCE
	rm -f lynx/_lynx.cfg

installdirs: lynx-installdirs
lynx-installdirs: FORCE
	$(INSTALL) -d ~/.profile.d/

install: lynx-install
lynx-install: FORCE lynx lynx-installdirs sh-install
	$(INSTALL_DATA) lynx/_lynx.cfg ~/.lynx.cfg
	$(INSTALL_DATA) lynx/_profile.d/lynx.sh ~/.profile.d/

uninstall: lynx-uninstall
lynx-uninstall: FORCE
	rm -f ~/.lynx.cfg ~/.profile.d/lynx.sh
