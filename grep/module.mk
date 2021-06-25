all: grep
grep: FORCE grep/_profile.d/grep.sh

installdirs: grep-installdirs
grep-installdirs: FORCE sh-installdirs

install: grep-install
grep-install: FORCE grep grep-installdirs sh-install
	$(INSTALL_DATA) grep/_profile.d/grep.sh ~/.profile.d/

uninstall: grep-uninstall
grep-uninstall: FORCE
	rm -f ~/.profile.d/grep.sh
