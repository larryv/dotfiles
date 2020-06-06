macports_files := macports/_profile.d/macports.sh

ifneq ($(shell grep -s /usr/libexec/path_helper /etc/zshenv),)
    macports_files += macports/_zsh/zshenv.d/macports.zsh
endif
