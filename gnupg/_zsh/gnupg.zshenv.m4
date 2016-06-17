__header__

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
if [[ -o LOGIN ]]
then
    export GPG_TTY="$(tty)"
fi

# vim: set filetype=zsh:
