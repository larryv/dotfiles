syscmd(«test -d ~/Downloads»)dnl
ifelse(sysval, «0», «SAVE_SPACE:~/Downloads

»)dnl
# Use quasiqwertyrc keymap if present.
INCLUDE:.lynx.cfg.quasiqwertyrc for KEYMAP

# Host-specific settings.
INCLUDE:.lynx.cfg.local

# vim: set filetype=lynx:
