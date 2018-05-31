tmux_files := tmux/_tmux.conf tmux/_zsh/tmux.zshrc

# Remove quasiqwertyrc symlink.
tmux-uninstall: tmux_dst_files += ~/.tmux.conf.quasiqwertyrc
