all: macports
macports: FORCE \
    macports/_profile.d/macports.sh \
    macports/_zsh/zshenv.d/macports.zsh

installdirs: macports-installdirs
macports-installdirs: FORCE
	$(INSTALL) -d ~/.profile.d/ ~/.zsh/zshenv.d/

install: macports-install
macports-install: FORCE macports macports-installdirs
	$(INSTALL_DATA) macports/_profile.d/macports.sh ~/.profile.d/
	if grep -s /usr/libexec/path_helper /etc/zshenv; then \
    $(INSTALL_DATA) \
        macports/_zsh/zshenv.d/macports.zsh ~/.zsh/zshenv.d/; \
fi

uninstall: macports-uninstall
macports-uninstall: FORCE
	rm -f ~/.profile.d/macports.sh ~/.zsh/zshenv.d/macports.zsh
