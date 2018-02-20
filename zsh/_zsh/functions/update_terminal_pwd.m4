# update_terminal_pwd
# -------------------
#
# Identify the current working directory to the terminal emulator. To
# use, register as a chpwd or precmd hook:
#
#     fpath=(/wherever/this/file/lives $fpath)
#
#     # With add-zsh-hook (requires zsh 4.3.4 or later).
#     autoload -Uz add-zsh-hook
#     add-zsh-hook -Uz chpwd update_terminal_pwd
#
#     # Without add-zsh-hook.
#     autoload -Uz update_terminal_pwd
#     typeset -a chpwd_functions
#     chpwd_functions+=update_terminal_pwd
#
# Currently supports OS X's Terminal.app.


emulate -L zsh

# TODO: Figure out how to communicate terminal type via SSH.
[[ ${TERM_PROGRAM} == Apple_Terminal || -n ${SSH_TTY} ]] || return

# Adapted from OS X's /etc/bashrc and the slightly-incorrect answer at
# https://stackoverflow.com/a/187853/50102.

# Percent-encode the path. Non-intuitively, we must *disable* MULTIBYTE
# to correctly encode multibyte Unicode characters. TODO: Implement some
# fallbacks for systems without hostname(1).
setopt EXTENDED_GLOB NO_MULTIBYTE
local fullpath="$(hostname -s)${PWD}"
local encodedpath=${fullpath//(#m)[^\/]/%$(([##16] ##${MATCH}))}

# This OSC sequence is from Terminal.app's General Preferences.
local fmt='\e]7;%s\a'

# Inside tmux, wrap the sequence to pass it through (see
# https://mail-archive.com/tmux-users@lists.sourceforge.net/msg03485.html).
[[ -n $TMUX ]] && fmt='\ePtmux;\e'${fmt}'\e\'

# Send escape sequence to the terminal emulator.
printf $fmt file://$encodedpath

# vim: set filetype=zsh: