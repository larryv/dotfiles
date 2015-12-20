# OS X's default /etc/zshenv runs path_helper(8), which screws up PATH
# if it's in the environment already (e.g., if zsh is run from the
# command line as a non-login shell). For non-login shells, move any
# existing MacPorts entries back to the beginning of PATH; for login
# shells, prepend all entries and remove duplicates.

if [[ ${OSTYPE} == darwin* ]]
then
    mp_prefix=__MACPORTS__
    mp_bin=( ${mp_prefix}/bin ${mp_prefix}/sbin )
    if [[ ! -o LOGIN ]]
    then
        # zsh 5.0.0: path=(${mp_bin:*path} ${path:|mp_bin})
        mp_bin=( ${(M)mp_bin:#${(~j:|:)path}} )
        path=( ${mp_bin} ${path} ) && path=( ${(u)path} )
    elif [[ -d ${mp_prefix} ]]
    then
        # zsh 5.0.0: path=(${mp_bin} ${path:|mp_bin})
        path=( ${mp_bin} ${path} ) && path=( ${(u)path} )
    fi
    unset mp_prefix mp_bin
fi
