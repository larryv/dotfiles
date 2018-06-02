# Modify the path here because OS X El Capitan and later initializes it
# in /etc/zprofile. macports_path should be created in macports.zshenv.

path=(${^macports_path}(N) $path)
unset macports_path

# vim: set filetype=zsh:
