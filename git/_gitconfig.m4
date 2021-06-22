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
	# Host-local settings.
	path = .gitconfig.local
divert(`-1')
vim: set filetype=gitconfig:
