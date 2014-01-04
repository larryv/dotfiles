# Disable terminal output flow control to allow CTRL-Q to be the tmux
# prefix key.

[[ -o LOGIN ]] && stty -ixon
