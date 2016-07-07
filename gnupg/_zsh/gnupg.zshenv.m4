__header__

[[ -o LOGIN ]] || return 0

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
export GPG_TTY="$(tty)"

# vim: set filetype=zsh:
