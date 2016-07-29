__header__

# Left: Hostname, history number, and privileges/shell-nesting
#   indicator, colored based on last exit status.
# Right: Current working directory, truncated to half screen width.
setopt PROMPT_SUBST
PS1='[%m] %B%h %(?.%F{green}.%F{red})${(r:$((SHLVL * 2))::%#:)}%f%b '
RPS1='%B%$((COLUMNS / 2))<..<%~%b'

# Add VCS info to the right-hand prompt (see zshcontrib(1)).
autoload -Uz vcs_info && {
    typeset -a precmd_functions
    precmd_functions+=vcs_info

    RPS1+='${vcs_info_msg_0_}'

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
}

# History.
setopt EXTENDED_HISTORY INC_APPEND_HISTORY_TIME
SAVEHIST=1000000
HISTSIZE=$SAVEHIST
HISTFILE=~/.zsh_history

# Aliases.
#
# TODO: Make the function versions handle argument quoting properly.
# This currently fails pretty badly. Just try running "ls" on
# a directory with a quoted space in its name.
if [[ $OSTYPE == darwin* ]]
then
    #hf (); emulate zsh -c "open -a 'Hex Fiend' $*"
    alias hf="open -a 'Hex Fiend'"
fi
#ls (); emulate zsh -c 'command ls -AFh '"$argv[*]"
alias ls='ls -AFh'

# Don't treat slashes as word characters.
WORDCHARS=${WORDCHARS/\//}

# Dress up tab completion.
autoload -Uz compinit && {
    compinit
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Enable various user contributions (see zshcontrib(1)).
contribs=( run-help zmv )
unalias "$contribs[@]" 2>/dev/null
autoload -Uz "$contribs[@]"
unset contribs

# Print timing stats for commands that run over 10 seconds.
REPORTTIME=10

# Identify the working directory to Terminal.app. Adapted from OS X's
# /etc/bashrc and the slightly-incorrect answer at
# http://stackoverflow.com/a/187853/50102.
if [[ $TERM_PROGRAM == Apple_Terminal ]]
then
    typeset -a precmd_functions
    precmd_functions+=update_terminal_pwd

    function update_terminal_pwd {
        emulate -L zsh

        # Percent-escape entire path. Non-intuitively, we must *disable*
        # MULTIBYTE to correctly encode multibyte Unicode characters.
        setopt EXTENDED_GLOB NO_MULTIBYTE
        local nonslash='(#m)[^/]'
        local host=${HOSTNAME//${~nonslash}/%$(([##16] ##${MATCH}))}
        local pwd=${PWD//${~nonslash}/%$(([##16] ##${MATCH}))}

        # Send escape sequence to Terminal.app. If running inside tmux,
        # use a "wrapper" sequence to protect the original (see
        # http://sourceforge.net/mailarchive/message.php?msg_id=27190530).
        local seq="${TMUX:+\ePtmux;\e}\e]7;%s\a${TMUX:+\e\\}"
        printf $seq file://${host}${pwd}
    }
fi

# The zsh documentation discourages setting environment variables from
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.
if [[ -o LOGIN ]]
then
    export EDITOR=vim
    export GREP_OPTIONS='--color=auto'
    export PAGER='less -S'
fi

# Source application-specific "topic" scripts.
for script in __zsh_dir__/*.zshrc(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
