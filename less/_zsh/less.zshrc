[[ -o LOGIN ]] || return 0

# Use quasiqwertyrc keybindings if available.
function {
    if [[ -f $1 ]]
    then
        export LESSKEY=$1
    fi
} ~/.quasiqwertyrc/${kbd_layout}/less

# vim: set filetype=zsh:
