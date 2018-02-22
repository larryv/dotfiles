__header__

ifdef(«__LYNX_CHARSET__», «CHARACTER_SET:__LYNX_CHARSET__

»)dnl
COOKIE_ACCEPT_DOMAINS:trac.macports.org
PERSISTENT_COOKIES:TRUE
COOKIE_FILE:__lynx_dir__/cookies

DEFAULT_BOOKMARK_FILE:__lynx_dir__/bookmarks.html

ifdef(«__LYNX_SAVE__», «SAVE_SPACE:__LYNX_SAVE__

»)dnl
# Use Colemakerel key mapping if present.
INCLUDE:__lynx_dir__/lynx.cfg.colemakerel for KEYMAP

# Host-specific settings.
INCLUDE:__lynx_dir__/lynx.cfg.local

divert(«-1»)
vim: set filetype=lynx:
