__header__

[[ -o LOGIN ]] || return 0

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html
GPG_TTY=$(tty) && export GPG_TTY || unset GPG_TTY

# vim: set filetype=zsh:
