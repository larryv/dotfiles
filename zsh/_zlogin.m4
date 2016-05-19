__header__

# Source application-specific "topic" scripts.
for script in __zsh__/*.zlogin(N)
do
    . $script
done

m4_ifelse(« vim: set filetype=zsh:»)m4_dnl
