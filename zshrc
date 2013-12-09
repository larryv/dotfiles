# Left prompt: Hostname, history number, and privileges/shell-nesting
#   indicator, colored based on last exit status
# Right prompt: Current working dir, truncated to half screen width
setopt PROMPT_SUBST
PS1='[%m] %B%h %(?.%F{green}.%F{red})${(r:$((${SHLVL} * 2))::%#:)}%f%b '
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

# Treat slashes as word separators
WORDCHARS=${WORDCHARS/\//}

# Dress up tab completion
autoload -Uz compinit && {
    compinit
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Enable fancy-pants on-line help
unalias run-help
autoload -Uz run-help

# Print timing stats for commands that run over 10 sec
REPORTTIME=10

# Disable terminal output flow control
[[ -o LOGIN ]] && stty -ixon

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
autoload -Uz vcs_info && {
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



########## BEGIN ZSHZLE POKERY-DIGGERY FOR COLEMAK ##########

bindkey -N emacs_colemak emacs
bindkey -A emacs_colemak main

# Movement
bindkey '^F' end-of-line            # ^E
bindkey '^T' forward-char           # ^F
bindkey '^X^T' vi-find-next-char    # ^X^F
bindkey '\eT' forward-word          # ESC-F
bindkey '\et' forward-word          # ESC-f

# History
bindkey '^K' down-line-or-history                   # ^N
bindkey '^P' history-incremental-search-backward    # ^R
bindkey '^Xp' history-incremental-search-backward   # ^Xr
bindkey '^R' history-incremental-search-forward     # ^S
bindkey '^Xr' history-incremental-search-forward    # ^Xs
bindkey '\e:' history-search-backward               # ESC-P
bindkey '\e;' history-search-backward               # ESC-p
bindkey '\eK' history-search-forward                # ESC-N
bindkey '\ek' history-search-forward                # ESC-n
bindkey '^X^K' infer-next-history                   # ^X^N

# Modifying
bindkey '\eI' down-case-word        # ESC-L
bindkey '\ei' down-case-word        # ESC-l
bindkey '\eS' kill-word             # ESC-D
bindkey '\es' kill-word             # ESC-d
bindkey '^X^N' vi-join              # ^X^J
bindkey '^E' kill-line              # ^K
bindkey '^X^E' kill-buffer          # ^X^K
bindkey '^L' kill-whole-line        # ^U
bindkey '^X^Y' overwrite-mode       # ^X^O
bindkey '\e^U' self-insert-unmeta   # ESC-^I
bindkey '\e^N' self-insert-unmeta   # ESC-^J
bindkey '^G' transpose-chars        # ^T
bindkey '\eG' transpose-words       # ESC-T
bindkey '\eg' transpose-words       # ESC-t
bindkey '\eL' up-case-word          # ESC-U
bindkey '\el' up-case-word          # ESC-u
bindkey '^J' yank                   # ^Y
bindkey '\ej' yank-pop              # ESC-y

# Completion
bindkey '^S' delete-char-or-list    # ^D
bindkey '\e^S' list-choices         # ESC-^D
bindkey '^Xd' list-expand           # ^Xg
bindkey '^XD' list-expand           # ^XG

# Miscellaneous
bindkey '^N' accept-line                    # ^J
bindkey '^Y' accept-line-and-down-history   # ^O
bindkey '\eD' get-line                      # ESC-G
bindkey '\ed' get-line                      # ESC-g
bindkey '^D' send-break                     # ^G
bindkey '\e^D' send-break                   # ESC-^G
bindkey '\eR' spell-word                    # ESC-S
bindkey '\er' spell-word                    # ESC-s
bindkey '^Xl' undo                          # ^Xu
bindkey '^X^L' undo                         # ^X^U

########## END ZSHZLE POKERY-DIGGERY FOR COLEMAK ##########
