# macports/_profile.d/macports.sh
# -------------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2015-2016, 2018, 2020-2023 by Lawrence Velazquez
# <vq@larryv.me>.
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


case $already_sourced in
    *' .profile.d/macports.sh '*)
        return 0
        ;;
    *)
        already_sourced="$already_sourced .profile.d/macports.sh " || return
        ;;
esac

# Define promote().
. ~/.profile.d/_functions.sh || return

# Move MacPorts directories to the beginning of PATH and MANPATH so its
# software and man pages take precedence over the system's.  I used to
# add the directories to PATH in this file, but any files sourced
# earlier could not find MacPorts' software.  Using /etc/paths.d and
# /etc/manpaths.d gets the directories into the paths sooner, but they
# are appended after the default entries.  (See the path_helper(8) man
# page for details.)

# Use a helper function for its temporary positional parameters.
promote_mp_paths() {
    # Like path_helper(8), treat newlines as delimiters and ignore blank
    # lines.  The files are usually very short, so using sed(1) for this
    # isn't worth it.  Use REPLY as the variable because promote() is
    # going to overwrite it anyway, so I don't have to unset it here.
    while IFS= read -r REPLY || [ "$REPLY" ]; do
        if [ "$REPLY" ]; then
            set -- "$@" "$REPLY" || return
        fi
    done <"$1" || return

    shift
    promote "$@"
}

# MacPorts does not put files in /etc/{paths,manpaths}.d; I create them
# myself.  They usually contain "/opt/local/bin", "/opt/local/sbin", and
# "/opt/local/share/man".

if [ "$PATH" ] && [ -e /etc/paths.d/macports ]; then
    promote_mp_paths /etc/paths.d/macports "$PATH" && PATH=$REPLY
fi

# MANPATH is only set on older versions of Mac OS X.
if [ "$MANPATH" ] && [ -e /etc/manpaths.d/macports ]; then
    promote_mp_paths /etc/manpaths.d/macports "$MANPATH" && MANPATH=$REPLY
fi

unset -v REPLY
unset -f promote_mp_paths
