__header__

# Reduce Esc timeout to accommodate Vim.
set-option -gs escape-time 50

# Make windows 1-indexed. I forget why.
set-option -g base-index 1

# Pass window titles to the terminal.
set-option -g set-titles on
set-option -g set-titles-string '#W'

# 256 colors? Truly we are living in the future
set-option -g default-terminal screen-256color

# Not a fan of the default neckbeard green.
set-option -g status-bg white

# Enable pasteboard use on OS X, if possible
# (https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard).
if-shell 'command -v reattach-to-user-namespace >/dev/null' \
    "set-option -g default-command \
            'exec reattach-to-user-namespace -l "$SHELL"'"

# Source Colemak keybindings if present.
dnl Determine whether this needs to be quoted and how to do so.
source-file -q 'printenv(«raw_prefix»)/.tmux.conf.colemakerel'

divert(«-1»)
vim: set filetype=tmux:
