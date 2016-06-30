__header__

# Source application-specific "topic" scripts.
for script in __zsh_dir__/*.zlogin(N)
do
    . $script
done

m4_ifelse(« vim: set filetype=zsh:»)m4_dnl
