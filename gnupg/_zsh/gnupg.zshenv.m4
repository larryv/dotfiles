__header__

# This configuration assumes GnuPG 2.1.11 or later.

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
if [[ -o LOGIN ]]
then
    export GPG_TTY="$(tty)"
fi

# vim: set filetype=zsh:
