# Disable terminal output flow control to allow quasiqwertyrc-vim to remap
# CTRL-S if necessary (http://unix.stackexchange.com/q/12107/2803).
# TODO Check for quasiqwertyrc-vim?
case ${kbd_layout} in
    Colemak)
        stty -ixon
        ;;
esac

# vim: set filetype=zsh:
