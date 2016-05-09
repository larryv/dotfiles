__header__

# Do this from .zprofile to mimic OS X's behavior in El Capitan and
# later. Abuse glob qualifiers to add only the path entries that exist
# and are directories (see "Glob Qualifiers" section of zshexpn(1)).
# macports_path is an array parameter created in macports.zshenv.

path=( $macports_path(/N) $path )
unset macports_path

# vim: filetype=zsh
