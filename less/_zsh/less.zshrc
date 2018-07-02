[[ -o LOGIN ]] || return 0

# Use quasiqwertyrc keybindings if available.
if [[ -f ~/.quasiqwertyrc/less ]]
then
    export LESSKEY=~/.quasiqwertyrc/less
fi

# vim: set filetype=zsh:
