__header__

syscmd(«test -d ~/Downloads»)dnl
ifelse(sysval, «0», «SAVE_SPACE:~/Downloads

»)dnl
# Use Colemakerel key mapping if present.
INCLUDE:__lynx_dir__/lynx.cfg.colemakerel for KEYMAP

# Host-specific settings.
INCLUDE:__lynx_dir__/lynx.cfg.local

divert(«-1»)
vim: set filetype=lynx:
