# zsh options
setopt extended_history     # Save timestamps to hist file
#setopt hist_ignore_dups     # Ignore consecutive duplicate events
setopt inc_append_history   # Continually append to hist file
setopt prompt_subst         # Allow expn and command subst in prompts

# History
export HISTFILE="${ZDOTDIR}/.zsh_history"
export HISTSIZE=1000000     # History kept in shell
export SAVEHIST=1000000     # Lines to save to history file

# emacs keybindings
bindkey -e

# Define file that compinstall should change
zstyle :compinstall filename "${ZDOTDIR}/.zshrc"

# Enable tab completion and dress it up a bit
autoload -Uz compinit && function {
    compinit -C
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Set prompt; use anonymous function to manage scope.
function {
    # (Taken from OS X /etc/bashrc.) Tell terminal about working dir.
    # Identify the directory using a "file:" scheme URL, including the host
    # name to disambiguate local vs. remote connections. Percent-escape
    # spaces.
    if [[ "${TERM_PROGRAM}" == "Apple_Terminal" && -z "${INSIDE_EMACS}" ]];
    then
        update_terminal_cwd () {
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
    local hist_number='%B%h%b'
    local privileges='%B%(?,%F{green},%F{red})%#%f%b'
    export PS1="${hostname} ${hist_number} ${privileges} "

    # Right-hand prompt
    local pwd='%B%1~%b'
    local vcs='${vcs_info_msg_0_}'
    export RPS1="${pwd}${vcs}"
}

# zsh env and parameters
export REPORTTIME=10        # Print timing stats if commands take too long

# Aliases
alias hf='open -a "Hex Fiend"'
alias ls='ls -AFh'

##### OS-specific settings #####

# if [[ "${OSTYPE}" =~ '^freebsd' ]]; then
#     # On FreeBSD, start ssh-agent
#     if ! (ssh-add -l &> /dev/null); then
#         eval $(ssh-agent -s)
#     fi
# fi
