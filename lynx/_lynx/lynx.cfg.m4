__header__

INCLUDE:__lynx_dir__/lynx.cfg.local

# The encoding I use with OS X Terminal; adjust as required.
CHARACTER_SET:utf-8

COOKIE_ACCEPT_DOMAINS:trac.macports.org
PERSISTENT_COOKIES:TRUE
COOKIE_FILE:__lynx_dir__/cookies

DEFAULT_BOOKMARK_FILE:__lynx_dir__/bookmarks.html

m4_ifdef(«__LYNX_SAVE__», «SAVE_SPACE:__LYNX_SAVE__

»)m4_dnl
# Use Colemakerel key mapping if present.
INCLUDE:__lynx_dir__/lynx.cfg.colemakerel for KEYMAP

m4_ifelse(« vim: set filetype=lynx:»)m4_dnl
