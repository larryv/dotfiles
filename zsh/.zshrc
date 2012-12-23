# zsh options
setopt extended_history     # Save timestamps to hist file
#setopt hist_ignore_dups     # Ignore consecutive duplicate events
setopt inc_append_history   # Continually append to hist file
setopt prompt_subst         # Allow expn and command subst in prompts

# History
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=1000000     # History kept in shell
export SAVEHIST=1000000     # Lines to save to history file

# zshzle
bindkey -e
export WORDCHARS="${WORDCHARS/\//}"

# Define file that compinstall should change
zstyle :compinstall filename "${ZDOTDIR}/.zshrc"

# Enable tab completion and dress it up a bit
autoload -Uz compinit && function {
    compinit
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Set prompt; use anonymous function to manage scope.
function {
    # Working directory code and comments are adapted from
    # OS X's /etc/bashrc.
    #
    # Tell the terminal about the working directory at each prompt.
    if [[ "${TERM_PROGRAM}" == "Apple_Terminal" && -z "${INSIDE_EMACS}" ]];
    then
        update_terminal_cwd () {
            # Identify the directory using a "file:" scheme URL,
            # including the host name to disambiguate local vs.
            # remote connections. Percent-escape spaces.
            printf '\e]7;%s\a' "file://${HOSTNAME}${PWD// /%20}"
        }
        local PC="A"
    fi

    # Version control info; see zshcontrib man page.
    if autoload -Uz vcs_info; then
        zstyle ':vcs_info:*' enable git hg svn
        zstyle ':vcs_info:*' formats ' (%s:%b)'
        zstyle ':vcs_info:*' actionformats ' (%s:%b|%a)'
        zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b/%r'

        # Change prompt colors in modified git repos
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' unstagedstr '%F{red}'
        zstyle ':vcs_info:git:*' stagedstr '%F{yellow}'
        zstyle ':vcs_info:git:*' formats ' %F{green}%u%c(%s:%b)%f'
        zstyle ':vcs_info:git:*' actionformats ' %F{green}%u%c(%s:%b|%a)%f'

        local PC="${PC}B"
    fi

    # Must define precmd all in one go
    case "${PC}" in
        A ) precmd () { update_terminal_cwd };;
        B ) precmd () { vcs_info };;
        AB ) precmd () { update_terminal_cwd; vcs_info };;
    esac

    # Left-hand prompt
    local hostname='[%m]'
    local hist_number='%h'
    local privileges='%(?.%F{green}.%F{red})%#%f'
    export PS1="${hostname} %B${hist_number} ${privileges}%b "

    # Right-hand prompt
    local pwd='%~'
    local vcs='${vcs_info_msg_0_}'
    export RPS1='%$((${COLUMNS} / 2))<..<%B'${pwd}'%b'${vcs}
}

# Aliases
if [[ -d "/Applications/Hex Fiend.app" ||
      -d "/Applications/MacPorts/Hex Fiend.app" ]]; then
    alias hf='open -a "Hex Fiend"'
fi
alias ls='ls -AFh'

# Misc
export REPORTTIME=10    # Print timing stats
stty -ixon              # Disable software flow control for terminal

##### OS-specific settings #####

# if [[ "${OSTYPE}" =~ '^freebsd' ]]; then
#     # On FreeBSD, start ssh-agent
#     if ! (ssh-add -l &> /dev/null); then
#         eval $(ssh-agent -s)
#     fi
# fi
