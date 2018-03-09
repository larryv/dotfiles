__header__

syscmd(«test -d ~/Downloads»)dnl
ifelse(sysval, «0», «SAVE_SPACE:~/Downloads

»)dnl
# Use Colemakerel key mapping if present.
INCLUDE:.lynx.cfg.colemakerel for KEYMAP

# Host-specific settings.
INCLUDE:.lynx.cfg.local

divert(«-1»)
vim: set filetype=lynx:
