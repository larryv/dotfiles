__header__

# Modify the path from .zprofile because OS X El Capitan (and later)
# sets it initially in /etc/zprofile. Abuse glob qualifiers to filter
# out invalid entries (see "Glob Qualifiers" section of zshexpn(1)).
# macports_path is an array parameter created in macports.zshenv.

path=(${^macports_path}(N) $path)
unset macports_path

# vim: set filetype=zsh:
