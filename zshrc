# Left prompt: Hostname, history number, and privileges indicator,
#              colored based on last exit status
# Right prompt: Current working dir, truncated to half screen width
setopt PROMPT_SUBST
PS1='[%m] %B%h %(?.%F{green}.%F{red})%#%f%b '
RPS1='%$((${COLUMNS} / 2))<..<%B%~%b'

# History
setopt EXTENDED_HISTORY INC_APPEND_HISTORY
HISTSIZE=1000
SAVEHIST=1000000
HISTFILE=${HOME}/.zsh_history

# Aliases
alias ls='ls -AFh'
if [[ -d "/Applications/Hex Fiend.app" ||
      -d "/Applications/MacPorts/Hex Fiend.app" ]]; then
    alias hf='open -a "Hex Fiend"'
fi

# emacs keybindings, and treat slashes as word separators
bindkey -e
WORDCHARS=${WORDCHARS/\//}

# Dress up tab completion
autoload -Uz compinit && function {
    compinit
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Print timing stats for commands that run over 10 sec
REPORTTIME=10

# Disable terminal output flow control
if [[ -o LOGIN ]]; then
    stty -ixon
fi

# Add a precmd hook to identify the working dir to Terminal.app.
# Adapted from OS X's /etc/bashrc and the slightly-incorrect answer at
# http://stackoverflow.com/a/187853/50102.
typeset -a precmd_functions
if [[ ${TERM_PROGRAM} == Apple_Terminal ]]; then
    function update_terminal_cwd {
        emulate -L zsh

        # Percent-escape entire path.  Non-intuitively, must *disable*
        # MULTIBYTE to correctly encode multibyte Unicode characters.
        setopt EXTENDED_GLOB NO_MULTIBYTE
        local nonslash='(#m)[^/]'
        local host=${HOSTNAME//${~nonslash}/%$(( [##16] ##${MATCH} ))}
        local cwd=${PWD//${~nonslash}/%$(( [##16] ##${MATCH} ))}

        # Send custom escape sequence to Terminal.app.  If zsh is
        # running inside tmux, use a "wrapper" sequence to pass the
        # original sequence through.  See
        # http://sourceforge.net/mailarchive/message.php?msg_id=27190530.
        if [[ -n ${TMUX} ]]; then
            printf '\ePtmux;\e\e]7;%s\a\e\' "file://${host}${cwd}"
        else
            printf '\e]7;%s\a' "file://${host}${cwd}"
        fi
    }
    precmd_functions+=update_terminal_cwd
fi

# Add a precmd hook to get VCS info for the prompt; see zshcontrib(1)
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

    precmd_functions+=vcs_info
    RPS1+='${vcs_info_msg_0_}'
}
