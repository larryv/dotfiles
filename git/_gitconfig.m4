[color]
	branch = auto
	diff = auto
[commit]
	# Requires Git 2.9.0 or later.
	verbose = true
[core]
	autocrlf = input
syscmd(«test -f /System/Library/LaunchDaemons/com.apple.revisiond.plist»)dnl
ifelse(sysval, «0», «dnl
	# Avoid problems with OS X revisiond.
	# https://www.git-tower.com/blog/make-git-rebase-safe-on-osx
	trustctime = false
»)dnl
[sendemail]
	suppresscc = self

[include]
	path = .gitconfig.local

divert(«-1»)
vim: set filetype=gitconfig:
