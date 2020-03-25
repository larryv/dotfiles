zsh_files := zsh/_zsh/_zlogin \
             zsh/_zsh/_zprofile \
             zsh/_zsh/_zshrc \
             zsh/_zsh/functions/update_terminal_cwd \
             zsh/_zshenv

# .zprofile relies on .profile to do most of its work.
zsh-install: sh-install
