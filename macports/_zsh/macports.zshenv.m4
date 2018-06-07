__header__

macports_path=(/opt/local/bin /opt/local/sbin)

# On OS X Yosemite and earlier, the system-installed /etc/zshenv
# unconditionally sets the command path using path_helper(8), which
# mangles a pre-existing path (e.g., if zsh is run from the command line
# as a non-login shell) by pushing the system's path entries to the
# front. Repair the damage by moving MacPorts' entries back to their
# rightful place.

command -p grep -qs /usr/libexec/path_helper /etc/zshenv && {
    # zsh 5.0.0: path=(${macports_path:*path} $path)
    path=(${(M)macports_path:#${(~j:|:)path}} $path)
}

# macports.zprofile handles this in login shells.
if [[ ! -o LOGIN ]]
then
    unset macports_path
fi

# vim: set filetype=zsh:
