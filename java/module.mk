all: java
java: FORCE java/_profile.d/java.sh

installdirs: java-installdirs
java-installdirs: FORCE
	$(INSTALL) -d ~/.profile.d/

install: java-install
java-install: FORCE java java-installdirs sh-install
	$(INSTALL_DATA) java/_profile.d/java.sh ~/.profile.d/

uninstall: java-uninstall
java-uninstall: FORCE
	rm -f ~/.profile.d/java.sh
