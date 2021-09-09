# git/_gitconfig.m4
# -----------------
#
# Written in 2012-2021 by Lawrence Velázquez <vq@larryv.me>.
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


[color]
	branch = auto
	diff = auto
[commit]
	# Requires Git 2.9.0 or later.
	verbose = true
[core]
	autocrlf = input
syscmd(`test -f /System/Library/LaunchDaemons/com.apple.revisiond.plist')dnl
ifelse(sysval, `0', `dnl
	# Avoid problems with Mac revisiond
	# (https://www.git-tower.com/blog/make-git-rebase-safe-on-osx).
	trustctime = false
')dnl
[init]
	# Requires Git 2.28.0 or later.
	defaultBranch = main
[rebase]
	# Requires Git 2.6.0 or later.
	missingCommitsCheck = error

[include]
	# Local settings.
	path = .gitconfig.local
divert(`-1')
vim: set filetype=gitconfig:
