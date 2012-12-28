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

# Set prompt; use anonymous function to manage scope
function {
    # Working directory code and comments are adapted from
    # OS X's /etc/bashrc.
    #
    # Identify the working directory to the terminal using a "file:"
    # scheme URL, including the host name to disambiguate local vs.
    # remote connections. Percent-escape spaces.
    if [[ ${TERM_PROGRAM} == Apple_Terminal ]]; then
        if [[ -n ${TMUX} ]]; then
            # Must explicitly tell tmux to pass the escape sequence
            # through to Terminal.app. See
            # http://sourceforge.net/mailarchive/message.php?msg_id=27190530.
            function update_terminal_cwd {
                local CWD_ESC_SEQ='\ePtmux;\e\e]7;%s\a\e\'
                printf ${CWD_ESC_SEQ} "file://${HOSTNAME}${PWD// /%20}"
            }
        else
            function update_terminal_cwd {
                local CWD_ESC_SEQ='\e]7;%s\a'
                printf ${CWD_ESC_SEQ} "file://${HOSTNAME}${PWD// /%20}"
            }
        fi
        local PC=A
    fi

    # Version control info; see zshcontrib(1) man page
    if autoload -Uz vcs_info; then
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

        RPS1+='${vcs_info_msg_0_}'
        local PC=${PC}B
    fi

    # Must define precmd all in one go
    case ${PC} in
        A ) function precmd { update_terminal_cwd } ;;
        B ) function precmd { vcs_info } ;;
        AB ) function precmd { update_terminal_cwd; vcs_info } ;;
    esac

}

# wtf is compinstall
zstyle :compinstall filename ${HOME}/.zshrc
