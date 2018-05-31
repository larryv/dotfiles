[[ -o LOGIN ]] || return 0

# Link the quasiqwertyrc keybindings.
update_ln .quasiqwertyrc/${kbd_layout}/tmux.conf ~/.tmux.conf.quasiqwertyrc

# vim: set filetype=zsh:
