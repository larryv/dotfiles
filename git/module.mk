all: git
git: FORCE git/_config/git/ignore git/_gitconfig

clean: git-clean
git-clean: FORCE
	rm -f git/_gitconfig

installdirs: git-installdirs
git-installdirs: FORCE
	$(INSTALL) -d ~/.config/git/

install: git-install
git-install: FORCE git git-installdirs
	$(INSTALL_DATA) git/_config/git/ignore ~/.config/git/
	$(INSTALL_DATA) git/_gitconfig ~/.gitconfig

uninstall: git-uninstall
git-uninstall: FORCE
	rm -f ~/.config/git/ignore ~/.gitconfig
