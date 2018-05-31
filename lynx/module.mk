lynx_files := lynx/_zsh/lynx.zshenv lynx/_zsh/lynx.zshrc
lynx_clean_files := lynx/_lynx.cfg

# Remove quasiqwertyrc symlink.
lynx-uninstall: lynx_dst_files += ~/.lynx.cfg.quasiqwertyrc
