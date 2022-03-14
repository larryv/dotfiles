# macports/_profile.d/macports.sh
# -------------------------------
#
# Written in 2015-2016, 2018, 2020-2022 by Lawrence Velázquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


# Move MacPorts directories to the beginning of PATH and MANPATH so its
# software and man pages take precedence over the system's.  I used to
# add the directories to PATH in this file, but any files sourced
# earlier could not find MacPorts' software.  Using /etc/paths.d and
# /etc/manpaths.d gets the directories into the paths sooner, but they
# are appended after the default entries.  (See the path_helper(8) man
# page for details.)

# Use a helper function for its temporary positional parameters.
promote_mp_paths() {
    [ -f "$1" ] || return

    # Like path_helper(8), treat newlines as delimiters and ignore blank
    # lines.  The files are usually very short, so using sed(1) for this
    # isn't worth it.
    while IFS= read -r REPLY || [ -n "$REPLY" ]; do
        [ -z "$REPLY" ] || set -- "$@" "$REPLY"
    done <"$1" || return
    unset REPLY

    shift
    promote "$@"
}

# MacPorts does not put files in /etc/{paths,manpaths}.d; I create them
# myself.  They usually contain "/opt/local/bin", "/opt/local/sbin", and
# "/opt/local/share/man".

if [ -n "${PATH+set}" ]; then
    _path=$(promote_mp_paths /etc/paths.d/macports "$PATH"; echo x)
    save_vars LC_ALL LC_CTYPE
    LC_ALL= LC_CTYPE=C
    PATH=${_path%?}
    restore_vars LC_ALL LC_CTYPE
    unset _path
fi

# MANPATH is only set on older versions of Mac OS X.
if [ -n "${MANPATH+set}" ]; then
    _manpath=$(promote_mp_paths /etc/manpaths.d/macports "$MANPATH"; echo x)
    save_vars LC_ALL LC_CTYPE
    LC_ALL= LC_CTYPE=C
    MANPATH=${_manpath%?}
    restore_vars LC_ALL LC_CTYPE
    unset _manpath
fi

unset -f promote_mp_paths
