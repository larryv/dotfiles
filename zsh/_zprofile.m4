__header__

# Source application-specific "topic" scripts.
for script in __zsh_dir__/*.zprofile(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
