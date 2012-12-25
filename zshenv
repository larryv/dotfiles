# This doesn't quite work in other startup files. Invoking zsh
# from inside another shell results in the MacPorts directories
# being at the END of PATH, rather than at the beginning. Not
# sure how. I'll take duplicate PATH elements instead.
if [[ "${OSTYPE}" =~ '^darwin' ]]; then
    # Set up path for MacPorts, if installed.
    if [[ -d /opt/local ]]; then
        export PATH="/opt/local/bin:/opt/local/sbin${PATH:+:${PATH}}"
    fi
fi
