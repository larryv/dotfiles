# On OS X 10.10 Yosemite and earlier, /etc/zshenv unconditionally redefines
# the command path using path_helper(8), even if zsh is run as a non-login
# shell (e.g., invoked from the command line to run a script). This puts the
# directories from /etc/paths back in front. In non-login shells, reclaim that
# position for MacPorts directories. (Login shells handle this via .zprofile.)

if [[ ! -o LOGIN ]]; then
    # >= 4.3.10: emulate sh -c '. ~/.profile.d/macports.sh'
    function {
        emulate -L sh
        . ~/.profile.d/macports.sh
    }
fi
