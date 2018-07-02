syscmd(«test -d ~/Downloads»)dnl
ifelse(sysval, «0», «SAVE_SPACE:~/Downloads

»)dnl
# Use quasiqwertyrc keymap if present.
INCLUDE:.quasiqwertyrc/lynx.cfg for KEYMAP

# Host-specific settings.
INCLUDE:.lynx.cfg.local

# vim: set filetype=lynx:
