# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
# https://www.gnupg.org/documentation/manuals/gnupg/Agent-Examples.html
if [ -z "$GPG_TTY" ]; then
    if gpg_tty=$(tty); then
        export GPG_TTY="$gpg_tty"
    fi
    unset gpg_tty
fi
