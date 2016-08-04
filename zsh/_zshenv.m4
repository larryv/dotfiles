__header__

ZDOTDIR='__zsh_dir__'

# Source application-specific "topic" scripts.
for script in $ZDOTDIR/*.zshenv(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
