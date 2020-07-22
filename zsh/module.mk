all: zsh
zsh: FORCE \
    zsh/_zsh/functions/update_terminal_cwd \
    zsh/_zsh/zlogin \
    zsh/_zsh/zprofile \
    zsh/_zsh/zshenv \
    zsh/_zsh/zshrc

installdirs: zsh-installdirs
zsh-installdirs: FORCE
	$(INSTALL) -d ~/.zsh/functions/

# ~/.zsh/zprofile sources ~/.profile.
install: zsh-install
zsh-install: FORCE sh-install zsh zsh-installdirs
	$(INSTALL_DATA) \
    zsh/_zsh/functions/update_terminal_cwd ~/.zsh/functions/
	$(INSTALL_DATA) \
    zsh/_zsh/zlogin zsh/_zsh/zprofile zsh/_zsh/zshenv zsh/_zsh/zshrc ~/.zsh/
	ln -fs zlogin ~/.zsh/.zlogin
	ln -fs zprofile ~/.zsh/.zprofile
	ln -fs .zsh/zshenv ~/.zshenv
	ln -fs zshrc ~/.zsh/.zshrc

uninstall: zsh-uninstall
zsh-uninstall: FORCE
	rm -f ~/.zsh/functions/update_terminal_cwd ~/.zsh/zlogin \
    ~/.zsh/zprofile ~/.zsh/zshenv ~/.zsh/zshrc ~/.zsh/.zlogin \
    ~/.zsh/.zprofile ~/.zshenv ~/.zsh/.zshrc
