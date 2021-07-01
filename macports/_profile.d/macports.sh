# macports/_profile.d/macports.sh
# -------------------------------
#
# Written in 2015-2016, 2018, 2020-2021 by Lawrence Velázquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#
# SPDX-License-Identifier: CC0-1.0


# Move MacPorts directories to the beginning of PATH and MANPATH so its
# software and man pages take precedence over the system's. I used to add the
# directories to PATH in this file, but any files sourced earlier could not
# find MacPorts-installed software. Using /etc/paths.d and /etc/manpaths.d
# gets the directories into the paths sooner, but they are appended after the
# default entries. (See the path_helper(8) man page for details.)

# MacPorts does not put files in /etc/{paths,manpaths}.d; I create them
# myself. They usually contain "/opt/local/bin", "/opt/local/sbin", and
# "/opt/local/share/man". As per path_helper(8), treat all newlines as
# delimiters and ignore blank lines.

mp_paths=/etc/paths.d/macports
if [ -n "${PATH+set}" ] && [ -f "$mp_paths" ]; then
    _path=$(sed '/./!d' "$mp_paths" | xargs2 promote "$PATH"; echo x)
    save_vars LC_ALL LC_CTYPE
    LC_ALL= LC_CTYPE=C
    PATH=${_path%?}
    restore_vars LC_ALL LC_CTYPE
    unset _path
fi

# MANPATH is only set on older versions of Mac OS X.
mp_manpaths=/etc/manpaths.d/macports
if [ -n "${MANPATH+set}" ] && [ -f "$mp_manpaths" ]; then
    _manpath=$(sed '/./!d' "$mp_manpaths" | xargs2 promote "$MANPATH"; echo x)
    save_vars LC_ALL LC_CTYPE
    LC_ALL= LC_CTYPE=C
    MANPATH=${_manpath%?}
    restore_vars LC_ALL LC_CTYPE
    unset _manpath
fi

unset mp_paths mp_manpaths
