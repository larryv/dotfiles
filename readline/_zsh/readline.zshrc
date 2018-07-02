[[ -o LOGIN ]] || return 0

# Use quasiqwertyrc keybindings if available.
if [[ -f ~/.quasiqwertyrc/inputrc ]]
then
    export INPUTRC=~/.quasiqwertyrc/inputrc
fi

# vim: set filetype=zsh:
