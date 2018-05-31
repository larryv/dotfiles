[[ -o LOGIN ]] || return 0

# Use quasiqwertyrc keybindings if available.
function {
    if [[ -f $1 ]]
    then
        export INPUTRC=$1
    fi
} ~/.quasiqwertyrc/${kbd_layout}/inputrc

# vim: set filetype=zsh:
