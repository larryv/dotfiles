installdirs: terminfo-installdirs
terminfo-installdirs: FORCE sh-installdirs

install: terminfo-install
terminfo-install: FORCE sh-install terminfo-installdirs \
    terminfo/_profile.d/terminfo.sh
	$(INSTALL_DATA) terminfo/_profile.d/terminfo.sh ~/.profile.d/

uninstall: terminfo-uninstall
terminfo-uninstall: FORCE
	rm -f ~/.profile.d/terminfo.sh
