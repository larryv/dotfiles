# terminfo/_profile.d/terminfo.sh
# -------------------------------
#
# SPDX-License-Identifier: CC0-1.0
#
# Written in 2020-2023 by Lawrence Velazquez <vq@larryv.me>.
#
# To the extent possible under law, the author has dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide.  This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software.  If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.


# shellcheck shell=sh


case $srcd in
	*' .profile.d/terminfo.sh '*)
		return 0
		;;
	*)
		srcd="$srcd .profile.d/terminfo.sh " || return
		;;
esac

# Set a more appropriate TERM if it is not feasible to configure the
# terminal emulator properly.

# Do nothing within screen or tmux.
if [ ! "$STY$TMUX" ]
then
	term=$TERM || return

	if
		# Version shouldn't be malformed but validate it anyway.
		[ "$TERM_PROGRAM" = Apple_Terminal ] \
			&& case $TERM_PROGRAM_VERSION in
			   	'' | *[!.0123456789]* | .* | *..* | *.) false ;;
			   esac
	then
		# https://invisible-island.net/ncurses/terminfo.src.html#toc-_Terminal_app
		#
		# Unconditionally override the "Declare terminal as"
		# preference because (according to a comment in the
		# terminfo source) it affects TERM but not the actual
		# emulation, which is itself not accurately described by
		# any of the preference's choices.  The required build
		# numbers are taken from the source.

		IFS=. read -r major minor rest <<EOF || return
$TERM_PROGRAM_VERSION
EOF
		# https://mywiki.wooledge.org/BashFAQ/067 -- There
		# shouldn't be any leading zeros, but strip them anyway.
		zeros=${major%%[!0]*} || return
		major=${major#"$zeros"}
		zeros=${minor%%[!0]*}
		minor=${minor#"$zeros"}

		if [ "$((major >= 400))" -ne 0 ]
		then
			term=nsterm-build400    # 10.13 and later
		elif [ "$((major >= 361))" -ne 0 ]
		then
			term=nsterm-build361    # 10.11 - 10.12
		elif [ "$((major == 343 && minor >= 7 || major > 343))" -ne 0 ]
		then
			# Mismatch is intentional; see terminfo source.
			term=nsterm-build343    # 10.10
		elif [ "$((major >= 326))" -ne 0 ]
		then
			term=nsterm-build326    # 10.9
		elif [ "$((major >= 303))" -ne 0 ]
		then
			# Mismatch is intentional; see terminfo source.
			term=nsterm-build309    # 10.7 - 10.8
		elif [ "$((major == 240 && minor >= 2 || major > 240))" -ne 0 ]
		then
			term=nsterm-16color     # 10.5 - 10.6
		elif [ "$((major >= 71))" -ne 0 ]
		then
			term=nsterm-bce         # 10.3 - 10.4
		fi

		unset -v major minor rest zeros
	fi

	if
		[ "$term" != "$TERM" ] \
			&& if [ "$ZSH_VERSION" ]
			   then
			   	# On assignment to TERM, zsh tries to
			   	# reinitialize the terminal.  As far as
			   	# I can tell, the only way to discern
			   	# failure is to check for an error
			   	# message, as neither the exit status
			   	# nor the assignment itself is affected.
			   	[ ! "$(TERM=$term 2>&1)" ]
			   else
			   	# Not sure whether "init" or "reset" is
			   	# better here.
			   	tput -T "$term" init 2>/dev/null
			   fi
	then
		TERM=$term && export TERM
	fi

	unset -v term
fi
