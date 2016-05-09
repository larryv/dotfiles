__header__

# Source any "topic" scripts. Customizations to enhance the
# functionality of external programs should be placed in
# __zsh__.

for script in __zsh__/*.zprofile(N)
do
    . $script
done

m4_ifelse(« vim: set filetype=zsh:»)m4_dnl
