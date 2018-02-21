__header__

# Source application-specific "topic" scripts.
for script in $ZDOTDIR/*.zlogin(N)
do
    . $script
done

divert(«-1»)
vim: set filetype=zsh:
