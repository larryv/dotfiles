# OS X's default /etc/zshenv runs path_helper(8), which screws up PATH
# if it's in the environment already (e.g., if zsh is run from the
# command line as a non-login shell). For non-login shells, move any
# existing MacPorts entries back to the beginning of PATH; for login
# shells, prepend all entries and remove duplicates.

if [[ $OSTYPE == darwin* ]]
then
    macports_path=( __MACPORTS__/bin __MACPORTS__/sbin )
    if [[ ! -o LOGIN ]]
    then
        # zsh 5.0.0: path=(${macports_path:*path} ${path:|macports_path})
        macports_path=( ${(M)macports_path:#${(~j:|:)path}} )
        path=( $macports_path $path ) && path=( ${(u)path} )
    else
        # zsh 5.0.0: path=(${macports_path} ${path:|macports_path})
        # Abuse glob qualifiers to add only the path entries that exist and are
        # directories (see "Glob Qualifiers" section of zshexpn(1)).
        path=( $macports_path(/N) $path ) && path=( ${(u)path} )
    fi
    unset macports_path
fi

# vim: filetype=zsh
