__header__

# Source application-specific "topic" scripts.
for script in __zsh_dir__/*.zprofile(N)
do
    . $script
done

m4_ifelse(« vim: set filetype=zsh:»)m4_dnl
