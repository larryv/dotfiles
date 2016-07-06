__header__

[[ -o LOGIN ]] || return 0

# This configuration assumes GnuPG 2.1.11 or later.

# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
export GPG_TTY="$(tty)"

# vim: set filetype=zsh:
