__header__

# For compatibility with zsh 4.3.6 and older, avoid the %F and %f prompt
# escapes and set colors with raw SGR parameters throughout.

# Left: Hostname, history number, and privileges/shell-nesting
#   indicator, colored green/red if last command succeeded/failed.
# Right: Current working directory, truncated to half screen width.
setopt PROMPT_SUBST
PS1='[%m] %B%h '\
$'%(?.%{\e[32m%}.%{\e[31m%})${(r:$((SHLVL * 2))::%#:)}%{\e[0m%}'\
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

    # Colorize based on repository status: Green/yellow/red for
    # no/staged/unstaged changes, respectively.
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr $'%{\e[31m%}'
    zstyle ':vcs_info:git:*' stagedstr $'%{\e[33m%}'
    zstyle ':vcs_info:git:*' formats $'%{\e[32m%}%u%c(%s:%b)%{\e[0m%}'
    zstyle ':vcs_info:git:*' actionformats \
            $'%{\e[32m%}%u%c(%s:%b|%a)%{\e[0m%}'

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
    zstyle ':completion:*:warnings' format \
            $'%B%{\e[31m%}No matches for %d%{\e[0m%}%b'
}

# Enable fancy globbing; stop at slashes when moving wordwise.
setopt EXTENDED_GLOB
WORDCHARS=${WORDCHARS/\//}

# History.
SAVEHIST=1000000
HISTSIZE=$SAVEHIST
HISTFILE=$ZDOTDIR/zsh_history
setopt EXTENDED_HISTORY
# Requires zsh 5.0.6. Hopefully I'll never use a shell so old that it
# requires setting APPEND_HISTORY explicitly.
setopt INC_APPEND_HISTORY_TIME 2>/dev/null

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
    export GREP_OPTIONS=--color=auto
    export PAGER=less
    export VISUAL=vim
fi

# Source application-specific "topic" scripts.
for script in $ZDOTDIR/*.zshrc(N)
do
    . $script
done

m4_divert(«-1»)
vim: set filetype=zsh:
