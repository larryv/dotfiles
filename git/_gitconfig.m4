__header__

[alias]
	c = commit --verbose
	ca = commit --verbose --amend
	d = diff
	dc = diff --cached
	l = log
	lom = log origin/master..
	rc = rebase --continue
	ri = rebase --interactive
	rim = rebase --interactive master
	riom = rebase --interactive origin/master
	s = status
	sb = show-branch
[color]
	branch = auto
	diff = auto
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
