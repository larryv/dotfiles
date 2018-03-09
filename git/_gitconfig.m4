__header__

[alias]
	a = add
	ae = add --edit
	ap = add --patch
	au = add --update
	c = commit
	ca = commit --amend
	d = diff
	dc = diff --cached
	rb = rebase
	rba = rebase --abort
	rbc = rebase --continue
	s = status
	sb = show-branch
[color]
	branch = auto
	diff = auto
[commit]
	# Requires Git 2.9.0 or later.
	verbose = true
[core]
	autocrlf = input
	excludesFile = "printenv(«raw_prefix»,«/["\\]/»,«"\\\\&"»)/.gitexclude"
syscmd(«test -f /System/Library/LaunchDaemons/com.apple.revisiond.plist»)dnl
ifelse(sysval, «0», «dnl
	# Avoid problems with OS X revisiond.
	# http://www.git-tower.com/blog/make-git-rebase-safe-on-osx
	trustctime = false
»)dnl
[sendemail]
	suppresscc = self

[include]
	path = .gitconfig.local

divert(«-1»)
vim: set filetype=gitconfig:
