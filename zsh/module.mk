zsh_files := zsh/_zsh/functions/update_terminal_cwd \
             zsh/_zsh/zlogin \
             zsh/_zsh/zprofile \
             zsh/_zsh/zshenv \
             zsh/_zsh/zshrc

# .zprofile relies on .profile to do most of its work.
zsh-install: sh-install

# Create links with the hidden names zsh requires.
zsh_link_srcs := zlogin zprofile .zsh/zshenv zshrc
zsh_link_tgts := ~/.zsh/.zlogin ~/.zsh/.zprofile ~/.zshenv ~/.zsh/.zshrc
zsh-install:
	$(call gencmds,ln -fs,$(zsh_link_srcs),$(zsh_link_tgts))
zsh-uninstall:
	$(RM) $(zsh_link_tgts)
