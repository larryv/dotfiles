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
[gpg]
	program = gpg2
[sendemail]
	suppresscc = self

[include]
	path = .gitconfig.local

m4_ifelse(« vim: set filetype=gitconfig:»)m4_dnl
