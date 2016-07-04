__header__

[alias]
	c = commit
	ca = commit --amend
	d = diff
	dc = diff --cached
	rb = rebase
	rbc = rebase --continue
	s = status
	sb = show-branch
[color]
	branch = auto
	diff = auto
[commit]
	# Requires 2.9.0 or later.
	verbose = true
[core]
	autocrlf = input
	excludesfile = __prefix__/.gitexclude
m4_syscmd(«test -f /System/Library/LaunchDaemons/com.apple.revisiond.plist»)m4_dnl
m4_ifelse(m4_sysval, «0», «m4_dnl
	# Avoid problems with OS X revisiond.
	# http://www.git-tower.com/blog/make-git-rebase-safe-on-osx
	trustctime = false
»)m4_dnl
[gpg]
	program = gpg2
[sendemail]
	suppresscc = self

[include]
	path = .gitconfig.local

m4_ifelse(« vim: set filetype=gitconfig:»)m4_dnl
