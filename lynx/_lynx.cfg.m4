syscmd(`test -d ~/Downloads')dnl
ifelse(sysval, `0', `SAVE_SPACE:~/Downloads

')dnl
# Host-local settings.
INCLUDE:.lynx.cfg.local

# vim: set filetype=lynx:
