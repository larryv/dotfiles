__header__

# Left: Hostname, history number, and privileges/shell-nesting
#   indicator, colored based on last exit status.
# Right: Current working directory, truncated to half screen width.
setopt PROMPT_SUBST
PS1='[%m] %B%h '\
'%(?.%F{green}.%F{red})${(r:$((SHLVL * 2))::%#:)}%f'\
'%b '
RPS1='%B%$((COLUMNS / 2))<..<%~%b'

# Add version control info to the right-hand prompt.
autoload -Uz vcs_info && vcs_info 2>/dev/null && {
    typeset -a precmd_functions
    precmd_functions+=vcs_info

    RPS1+='${vcs_info_msg_0_:+ ${vcs_info_msg_0_}}'

    zstyle ':vcs_info:*' enable git hg svn

    zstyle ':vcs_info:*' formats '(%s:%b)'
    zstyle ':vcs_info:*' actionformats '(%s:%b|%a)'
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b/%r'

    # Colorize based on repository status.
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr '%F{red}'
    zstyle ':vcs_info:git:*' stagedstr '%F{yellow}'
    zstyle ':vcs_info:git:*' formats '%F{green}%u%c(%s:%b)%f'
    zstyle ':vcs_info:git:*' actionformats '%F{green}%u%c(%s:%b|%a)%f'

    zstyle ':vcs_info:*' disable-patterns \
            "~/Projects/(ast|gcc)(|/*)"
}

# Send current working directory to the terminal emulator.
autoload -Uz update_terminal_pwd && update_terminal_pwd 2>/dev/null && {
    typeset -a precmd_functions
    precmd_functions+=update_terminal_pwd
}

# Enable completion and other things.
autoload -Uz run-help zargs zrecompile
autoload -Uz compinit && compinit && {
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:warnings' format '%B%F{red}No matches for %d%f%b'
}

# Enable fancy globbing; stop at slashes when moving wordwise.
setopt EXTENDED_GLOB
WORDCHARS=${WORDCHARS/\//}

# History.
SAVEHIST=1000000
HISTSIZE=$SAVEHIST
HISTFILE=$ZDOTDIR/zsh_history
setopt EXTENDED_HISTORY INC_APPEND_HISTORY_TIME

# Aliases.
#
# TODO: Make the function versions handle argument quoting properly.
# This currently fails pretty badly. Just try running "ls" on
# a directory with a quoted space in its name.
# TODO: Only alias Hex Fiend if it exists.
if [[ $OSTYPE == darwin* ]]
then
    #hf (); emulate zsh -c "open -a 'Hex Fiend' $*"
    alias hf="open -a 'Hex Fiend'"
fi
#ls (); emulate zsh -c 'command ls -AFh '"$argv[*]"
alias ls='ls -AFh'

# Print timing stats for commands that run over 10 seconds.
REPORTTIME=10

# The zsh documentation discourages setting environment variables from
# .zprofile or .zlogin (http://zsh.sourceforge.net/Intro/intro_3.html),
# so do it here.
if [[ -o LOGIN ]]
then
    export EDITOR=vim
    export GREP_OPTIONS=--color=auto
    export PAGER='less -S'
fi

# Source application-specific "topic" scripts.
for script in $ZDOTDIR/*.zshrc(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
