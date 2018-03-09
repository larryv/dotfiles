__header__

ZDOTDIR='printenv(«quoted_zsh_dir»)'

# I can't think of a good reason to allow duplicates in these arrays.
typeset -aU fpath path

fpath=($ZDOTDIR/functions(N) $fpath)

# Source application-specific "topic" scripts.
for script in $ZDOTDIR/*.zshenv(N)
do
    . $script
done

divert(«-1»)
vim: set filetype=zsh:
