# OS X's default /etc/zshenv runs path_helper(8), which screws up PATH
# if it's in the environment already (e.g., if zsh is run from the
# command line as a non-login shell). For non-login shells, move any
# existing MacPorts entries back to the beginning of PATH; for login
# shells, prepend all entries and remove duplicates.

if [[ $OSTYPE == darwin* ]]
then
    macports_prefix=__MACPORTS__
    macports_bin=( ${macports_prefix}/bin ${macports_prefix}/sbin )
    if [[ ! -o LOGIN ]]
    then
        # zsh 5.0.0: path=(${macports_bin:*path} ${path:|macports_bin})
        macports_bin=( ${(M)macports_bin:#${(~j:|:)path}} )
        path=( $macports_bin $path ) && path=( ${(u)path} )
    elif [[ -d $macports_prefix ]]
    then
        # zsh 5.0.0: path=(${macports_bin} ${path:|macports_bin})
        path=( $macports_bin $path ) && path=( ${(u)path} )
    fi
    unset macports_prefix macports_bin
fi

# vim: filetype=zsh
