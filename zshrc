# Left prompt: Hostname, history number, and privileges indicator,
#              colored based on last exit status
# Right prompt: Current working dir, truncated to half screen width
setopt PROMPT_SUBST
export PS1='[%m] %B%h %(?.%F{green}.%F{red})%#%f%b '
export RPS1='%$((${COLUMNS} / 2))<..<%B%~%b'

# History
setopt EXTENDED_HISTORY INC_APPEND_HISTORY
export HISTSIZE=1000
export SAVEHIST=1000000
export HISTFILE=${HOME}/.zsh_history

# Aliases
alias ls='ls -AFh'
if [[ -d "/Applications/Hex Fiend.app" ||
      -d "/Applications/MacPorts/Hex Fiend.app" ]]; then
    alias hf='open -a "Hex Fiend"'
fi

# emacs keybindings, and treat slashes as word separators
bindkey -e
export WORDCHARS=${WORDCHARS/\//}

# Dress up tab completion
autoload -Uz compinit && function {
    compinit
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Print timing stats for commands that run over 10 sec
export REPORTTIME=10

# Use the chpwd hook to identify the working dir to Terminal.app. If
# inside tmux, must use a "wrapper" sequence to pass the original escape
# sequence through.  (See
# http://sourceforge.net/mailarchive/message.php?msg_id=27190530.)
#
# Adapted from OS X's /etc/bashrc.
if [[ ${TERM_PROGRAM} == Apple_Terminal ]]; then
    function chpwd {
        local CWD_ESC_SEQ='\e]7;%s\a'
        if [[ -n ${TMUX} ]]; then CWD_ESC_SEQ='\ePtmux;\e\e]7;%s\a\e\'; fi
        printf ${CWD_ESC_SEQ} "file://${HOSTNAME}${PWD// /%20}"
    }
    chpwd       # Otherwise new terminals won't have the pwd
fi

# Use the precmd hook to get VCS info for the prompt; see zshcontrib(1)
autoload -Uz vcs_info && function {
    zstyle ':vcs_info:*' enable git hg svn
    zstyle ':vcs_info:*' formats ' (%s:%b)'
    zstyle ':vcs_info:*' actionformats ' (%s:%b|%a)'
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b/%r'

    # Color-code git info based on repo status
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr '%F{red}'
    zstyle ':vcs_info:git:*' stagedstr '%F{yellow}'
    zstyle ':vcs_info:git:*' formats ' %F{green}%u%c(%s:%b)%f'
    zstyle ':vcs_info:git:*' actionformats ' %F{green}%u%c(%s:%b|%a)%f'

    function precmd { vcs_info }
    RPS1+='${vcs_info_msg_0_}'
}

# wtf is compinstall
zstyle :compinstall filename ${HOME}/.zshrc
