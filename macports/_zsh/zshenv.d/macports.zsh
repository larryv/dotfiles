# On OS X 10.10 Yosemite and earlier, /etc/zshenv unconditionally redefines
# the command path using path_helper(8), even if zsh is run as a non-login
# shell (e.g., invoked from the command line to run a script). This puts the
# directories from /etc/paths back in front. In non-login shells, reclaim that
# position for MacPorts directories. (Login shells handle this via .zprofile.)

if [[ ! -o LOGIN ]]; then
    # >= 4.3.7: () { emulate -L sh; . ~/.profile.d/macports.sh; }
    # >= 4.3.10: emulate sh -c '. ~/.profile.d/macports.sh'
    function fix_macports_path {
        emulate -L sh
        . ~/.profile.d/macports.sh && unset -f -- "$0"

        # https://www.zsh.org/mla/users/2008/msg00785.html (users/13169)
        # < 4.3.7: Options are restored at function exit but emulation mode is
        # not. Explicitly revert to zsh mode, or things get weird later.
        emulate -L zsh
    }
    fix_macports_path
fi
